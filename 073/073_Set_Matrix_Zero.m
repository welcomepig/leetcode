#import <Foundation/Foundation.h>
#import <stdio.h>

@interface DoubleArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, strong) NSMutableArray *data;

-(void)addRow:(NSArray*)data;
-(void)setZeros;
-(void)setZerosCSpace;

@end
  
@implementation DoubleArray

-(NSInteger)row
{
    if (self.data) {
        return self.data.count;
    }
    
    return 0;
}

-(NSInteger)column
{
    if (self.data && self.data.count > 0) {
        return ((NSMutableArray*)self.data[0]).count;
    }
    
    return 0;
}
    
-(void)addRow:(NSArray*)data
{
    if (!self.data) {
        self.data = [NSMutableArray array];
    }
    [self.data addObject:[data mutableCopy]];
}

/* O(m * n) time O(m + n) space */
-(void)setZeros
{
    NSInteger i, j;
    NSMutableSet *zeroRow = [NSMutableSet set];
    NSMutableSet *zeroColumn = [NSMutableSet set];
    
    NSMutableArray *rowData;
    
    for (i = 0;i < self.row; i++) {
        rowData = (NSMutableArray*)self.data[i];
        for (j = 0;j < self.column; j++) {
            if ([(NSNumber*)rowData[j] intValue] == 0) {
                [zeroRow addObject:@(i)];
                [zeroColumn addObject:@(j)];
            }
        }
    }
    
    for (NSObject *row in zeroRow) {
        rowData = (NSMutableArray*)self.data[[(NSNumber*)row intValue]];
        for (j = 0;j < self.column; j++) {
            rowData[j] = @(0);
        }
    }
    
    for (NSObject *column in zeroColumn) {
        for (i = 0;i < self.row; i++) {
            rowData = (NSMutableArray*)self.data[i];
            rowData[[(NSNumber*)column intValue]] = @(0);
        }
    }
}

/* O(m * n) time O(1) space */
-(void)setZerosCSpace
{
    NSInteger i, j;
    NSInteger row0 = 1, col0 = 1;
    NSMutableArray *rowData, *rowData2;
    
    for (i = 0;i < self.row; i++) {
        rowData = (NSMutableArray*)self.data[i];
        if ([(NSNumber*)rowData[0] intValue] == 0) {
            col0 = 0;
        }
        for (j = 0;j < self.column; j++) {
            if ([(NSNumber*)rowData[j] intValue] == 0) {
                if (i == 0) row0 = 0;
                if (j == 0) col0 = 0;
                
                rowData[0] = @(0);
                rowData2 = (NSMutableArray*)self.data[0];
                rowData2[j] = @(0);
            }
        }
    }
    
    for (i = 1;i < self.row; i++) {
        rowData = (NSMutableArray*)self.data[i];
        for (j = 1;j < self.column; j++) {
            rowData2 = (NSMutableArray*)self.data[0];
            if ([(NSNumber*)rowData[0] intValue] == 0 || 
                [(NSNumber*)rowData2[j] intValue] == 0) {
                rowData[j] = @(0);
            }
        }
    }
    
    if (row0 == 0) {
        rowData = (NSMutableArray*)self.data[0];
        for (j = 0;j < self.column; j++) {
            rowData[j] = @(0);
        }
    }
    
    if (col0 == 0) {
        for (i = 0;i < self.row; i++) {
            rowData2 = (NSMutableArray*)self.data[i];
            rowData2[0] = @(0);
        }
    }
}

-(NSString*)description
{
    NSMutableString *desc = [NSMutableString string];
    
    for (NSInteger i = 0;i < self.row; i++) {
        NSMutableArray *rowData = (NSMutableArray*)self.data[i];
        for (NSInteger j = 0;j < self.column; j++) {
            [desc appendFormat:@"%ld ", [(NSNumber*)rowData[j] intValue]];
        }
        [desc appendFormat:@"\n"];
    }
    
    return [desc copy];
}

@end


int main (int argc, const char * argv[])
{
    @autoreleasepool {
        DoubleArray *data = [[DoubleArray alloc] init];
        [data addRow:@[@(1), @(1), @(3), @(4)]];
        [data addRow:@[@(1), @(1), @(3), @(4)]];
        [data addRow:@[@(0), @(1), @(3), @(4)]];
        NSLog(@"%@", data);
        [data setZerosCSpace];
        NSLog(@"%@", data);
    }
}

