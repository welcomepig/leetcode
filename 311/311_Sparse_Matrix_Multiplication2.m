#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger **data;

-(instancetype)initWithData:(NSInteger **)data row:(NSInteger)row column:(NSInteger)column;
-(TwoDimArray*)multiply:(TwoDimArray*)matrix;

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

-(void)printArray
{
    NSInteger i, j;
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            NSLog(@"%ld", self.data[i][j]);
        }
    }
}

-(TwoDimArray*)multiply:(TwoDimArray*)matrix
{
    NSInteger i, j, k, row = self.row, column = matrix.column;
    
    NSInteger **a = (NSInteger **)malloc(sizeof(NSInteger *) * row);
    for (i = 0;i < row; i++) {
        a[i] = (NSInteger *)malloc(sizeof(NSInteger) * column);
    }
    
    for (i = 0;i < row; i++) {
        for (k = 0;k < self.column; k++) {
            if (self.data[i][k] == 0) continue;
            for (j = 0;j < column; j++) {
                if (matrix.data[k][j] == 0) continue;
                a[i][j] = a[i][j] + self.data[i][k] * matrix.data[k][j];
            }
        }
    }
    
    return [[TwoDimArray alloc] initWithData:a row:row column:column];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSInteger i;
        NSInteger **a = (NSInteger **)malloc(sizeof(NSInteger *) * 2);
        for (i = 0;i < 2; i++) {
            a[i] = (NSInteger *)malloc(sizeof(NSInteger) * 3);
        }
        
        a[0][0] = 1;
        a[0][1] = 0;
        a[0][2] = 0;
        
        a[1][0] = -1;
        a[1][1] = 0;
        a[1][2] = 3;
        
        TwoDimArray *A = [[TwoDimArray alloc] initWithData:a row:2 column:3];
        
        NSInteger **b = (NSInteger **)malloc(sizeof(NSInteger *) * 3);
        for (i = 0;i < 3; i++) {
            b[i] = (NSInteger *)malloc(sizeof(NSInteger) * 3);
        }
        
        b[0][0] = 7;
        b[0][1] = 0;
        b[0][2] = 0;
        
        b[1][0] = 0;
        b[1][1] = 0;
        b[1][2] = 0;
        
        b[2][0] = 0;
        b[2][1] = 0;
        b[2][2] = 1;
        
        TwoDimArray *B = [[TwoDimArray alloc] initWithData:b row:3 column:3];
        TwoDimArray *result = [A multiply:B];
        [result printArray];
    }
}

