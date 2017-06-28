#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) NSUInteger column;
@property (nonatomic, assign) NSInteger **matrix;

-(instancetype)initWithRow:(NSUInteger)row column:(NSUInteger)column matrix:(NSInteger **)matrix;
-(void)calculateNearestDistance;

@end

@implementation TwoDimArray

-(instancetype)initWithRow:(NSUInteger)row column:(NSUInteger)column matrix:(NSInteger **)matrix
{
    self = [super init];
    if (self) {
        _row = row;
        _column = column;
        _matrix = matrix;
    }
    return self;
}

-(NSString*)description
{
    NSMutableString *desc = [NSMutableString string];
    
    NSUInteger i, j;
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            [desc appendFormat:@"%ld ", self.matrix[i][j]];
        }
        [desc appendString:@"\n"];
    }
    
    return [desc copy];
}

-(void)calculateNearestDistance
{
    NSUInteger i, j;

    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.matrix[i][j] == 0) {
                [self calculateNeighborDistance:i col:j dist:0];
            }
        }
    }
}

-(void)calculateNeighborDistance:(NSUInteger)row col:(NSUInteger)col dist:(NSInteger)dist
{
    [self calculateDistance:(row - 1) col:col dist:(dist + 1)];
    [self calculateDistance:(row + 1) col:col dist:(dist + 1)];
    [self calculateDistance:row col:(col - 1) dist:(dist + 1)];
    [self calculateDistance:row col:(col + 1) dist:(dist + 1)];
}

-(void)calculateDistance:(NSInteger)i col:(NSInteger)j dist:(NSInteger)dist
{
    if (i < 0 || i >= self.row) {
        return;
    }
    
    if (j < 0 || j >= self.column) {
        return;
    }
    
    if (self.matrix[i][j] < dist) {
        // include 0 and 1
        return;
    }
    
    self.matrix[i][j] = dist;
    [self calculateNeighborDistance:i col:j dist:dist];
}

-(void)calculateNearestDistanceBFS
{
    NSInteger i, j, dist;
    NSMutableArray *queue = [NSMutableArray array];
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.matrix[i][j] == 0) {
                [queue addObject:@(i)];
                [queue addObject:@(j)];
            }
        }
    }
    
    while (queue.count > 0) {
        i = [queue[0] integerValue];
        j = [queue[1] integerValue];
        [queue removeObjectAtIndex:0];
        [queue removeObjectAtIndex:0];
        
        dist = self.matrix[i][j] + 1;
        if (i - 1 >= 0 && self.matrix[i-1][j] == NSIntegerMax) {
            self.matrix[i-1][j] = dist;
            [queue addObject:@(i-1)];
            [queue addObject:@(j)];
        }
        if (i + 1 < self.row && self.matrix[i+1][j] == NSIntegerMax) {
            self.matrix[i+1][j] = dist;
            [queue addObject:@(i+1)];
            [queue addObject:@(j)];
        }
        if (j - 1 >= 0 && self.matrix[i][j-1] == NSIntegerMax) {
            self.matrix[i][j-1] = dist;
            [queue addObject:@(i)];
            [queue addObject:@(j-1)];
        }
        if (j + 1 < self.column && self.matrix[i][j+1] == NSIntegerMax) {
            self.matrix[i][j+1] = dist;
            [queue addObject:@(i)];
            [queue addObject:@(j+1)];
        }
    }
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        int r = 4, c = 4;
        
        NSInteger **matrix = (NSInteger **)malloc(r * sizeof(NSInteger *));
        for (int i = 0; i < r; i++)
            matrix[i] = (NSInteger *)malloc(c * sizeof(NSInteger));
        
        matrix[0][0] = matrix[0][3] = matrix[1][0] = matrix[1][1] = matrix[1][2] =
        matrix[2][0] = matrix[2][2] = matrix[3][2] = matrix[3][3] = NSIntegerMax;
        matrix[0][1] = matrix[1][3] = matrix[2][1] = matrix[2][3] = matrix[3][1] = -1;
        matrix[0][2] = matrix[3][0] = 0;
        
        TwoDimArray *data = [[TwoDimArray alloc] initWithRow:r column:c matrix:matrix];
        [data calculateNearestDistanceBFS];
        NSLog(@"%@", data);
    }
}

