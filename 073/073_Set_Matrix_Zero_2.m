#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger **data;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;

-(instancetype)initWithData:(NSInteger**)data row:(NSInteger)row column:(NSInteger)column;
-(void)setMatrixZero;

@end

@implementation TwoDimArray

-(NSString*)description
{
    NSMutableString *desc = [NSMutableString string];
    for (int i = 0;i < self.row; i++) {
        for (int j = 0;j < self.column; j++) {
            NSLog(@"%ld ", self.data[i][j]);
        }
    }
    
    return [desc copy];
}

-(instancetype)initWithData:(NSInteger**)data row:(NSInteger)row column:(NSInteger)column
{
    self = [super init];
    if (self) {
        _data = data;
        _row = row;
        _column = column;
    }
    return self;
}

-(void)setMatrixZero
{
    BOOL isFirstRowEqualZero = NO;
    for (int i = 0;i < self.row; i++) {
        for (int j = 0;j < self.column; j++) {
            if (self.data[i][j] == 0) {
                if (i == 0) {
                    isFirstRowEqualZero = YES;
                } else {
                    self.data[i][0] = 0;
                }
                self.data[0][j] = 0;
            }
        }
    }
    
    for (int j = 1;j < self.column; j++) {
        if (self.data[0][j] == 0) {
            for (int i = 0;i < self.row; i++) {
                self.data[i][j] = 0;
            }
        }
    }
    
    for (int i = 1;i < self.row; i++) {
        if (self.data[i][0] == 0) {
            for (int j = 0;j < self.column; j++) {
                self.data[i][j] = 0;
            }
        }
    }
    
    if (self.data[0][0] == 0) {
        for (int i = 0;i < self.row; i++) {
            self.data[i][0] = 0;
        }
    }
    
    if (isFirstRowEqualZero) {
        for (int j = 0;j < self.column; j++) {
            self.data[0][j] = 0;
        }
    }
}

@end
 
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSInteger row = 3, column = 4;
        
        NSInteger **data = (NSInteger **)malloc(row * sizeof(NSInteger*));
        for (int i = 0;i < row; i++) {
            data[i] = (NSInteger *)malloc(column * sizeof(NSInteger));
        }
        
        data[0][0] = 0;
        data[0][1] = 1;
        data[0][2] = 3;
        data[0][3] = 4;
        
        data[1][0] = 1;
        data[1][1] = 1;
        data[1][2] = 3;
        data[1][3] = 4;
        
        data[2][0] = 0;
        data[2][1] = 1;
        data[2][2] = 3;
        data[2][3] = 4;
        
        TwoDimArray *data2 = [[TwoDimArray alloc] initWithData:data row:row column:column];
        [data2 setMatrixZero];
        NSLog(@"%@", data2);
    }
}
