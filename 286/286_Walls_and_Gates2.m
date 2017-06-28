#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger **data;

-(instancetype)initWithData:(NSInteger **)data row:(NSInteger)row column:(NSInteger)column;

@end

@implementation TwoDimArray

-(instancetype)initWithData:(NSInteger **)data row:(NSInteger)row column:(NSInteger)column
{
    self = [super init];
    if (self) {
        _data = data;
        _row = row;
        _column = column;
    }
    return self;
}

-(void)calculateDistance:(NSInteger)dist i:(NSInteger)i j:(NSInteger)j
{
    if (i < 0 || j < 0 || i >= self.row || j >= self.column ||
        self.data[i][j] == -1 || self.data[i][j] < dist) {
        return;
    }
    
    self.data[i][j] = dist;
    [self calculateDistance:(dist+1) i:(i+1) j:j];
    [self calculateDistance:(dist+1) i:(i-1) j:j];
    [self calculateDistance:(dist+1) i:i j:(j+1)];
    [self calculateDistance:(dist+1) i:i j:(j-1)];
}

-(void)wallsAndGatesDFS
{
    NSInteger i, j;
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.data[i][j] == 0) {
                [self calculateDistance:0 i:i j:j];
            }
        }
    }
}

-(void)fillDist:(NSInteger)dist i:(NSInteger)i j:(NSInteger)j queue:(NSMutableArray*)queue
{
    if (i < 0 || j < 0 || i >= self.row || j >= self.column || self.data[i][j] < dist) {
        return;
    }
    
    self.data[i][j] = dist;
    [queue addObject:@(i)];
    [queue addObject:@(j)];
}

-(void)wallsAndGatesBFS
{
    NSInteger i, j, k, dist, count;
    NSMutableArray *queue = [NSMutableArray array];
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.data[i][j] == 0) {
                [queue addObject:@(i)];
                [queue addObject:@(j)];
            }
        }
    }
    
    dist = 1;
    while (queue.count > 0) {
        count = queue.count / 2;
        for (k = 0;k < count; k++) {
            i = [queue[0] integerValue];
            j = [queue[1] integerValue];
            [queue removeObjectAtIndex:0];
            [queue removeObjectAtIndex:0];
            
            [self fillDist:dist i:(i-1) j:j queue:queue];
            [self fillDist:dist i:(i+1) j:j queue:queue];
            [self fillDist:dist i:i j:(j-1) queue:queue];
            [self fillDist:dist i:i j:(j+1) queue:queue];
        }
        dist++;
    }
    
}

-(void)wallsAndGatesDP
{
    NSInteger i, j, k, dist, count;
    NSMutableArray *queue = [NSMutableArray array];
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.data[i][j] == 0) {
                [queue addObject:@(i)];
                [queue addObject:@(j)];
            }
        }
    }
    
    dist = 1;
    while (queue.count > 0) {
        count = queue.count / 2;
        for (k = 0;k < count; k++) {
            i = [queue[0] integerValue];
            j = [queue[1] integerValue];
            [queue removeObjectAtIndex:0];
            [queue removeObjectAtIndex:0];
            
            [self fillDist:dist i:(i-1) j:j queue:queue];
            [self fillDist:dist i:(i+1) j:j queue:queue];
            [self fillDist:dist i:i j:(j-1) queue:queue];
            [self fillDist:dist i:i j:(j+1) queue:queue];
        }
        dist++;
    }
    
}

-(void)printArray
{
    NSInteger i, j;
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            NSLog(@"%ld", self.data[i][j]);
        }
    }
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSInteger i, row = 4, column = 4;
        
        NSInteger **board = (NSInteger **)malloc(sizeof(NSInteger *) * row);
        for (i = 0;i < row; i++) {
            board[i] = (NSInteger *)malloc(sizeof(NSInteger) * column);
        }
        
        board[0][0] = NSIntegerMax;
        board[0][1] = -1;
        board[0][2] = 0;
        board[0][3] = NSIntegerMax;
        
        board[1][0] = NSIntegerMax;
        board[1][1] = NSIntegerMax;
        board[1][2] = NSIntegerMax;
        board[1][3] = -1;
        
        board[2][0] = NSIntegerMax;
        board[2][1] = -1;
        board[2][2] = NSIntegerMax;
        board[2][3] = -1;
        
        board[3][0] = 0;
        board[3][1] = -1;
        board[3][2] = NSIntegerMax;
        board[3][3] = NSIntegerMax;
        
        TwoDimArray *array = [[TwoDimArray alloc] initWithData:board row:row column:column];
        [array wallsAndGatesBFS];
        [array printArray];
    }
}

