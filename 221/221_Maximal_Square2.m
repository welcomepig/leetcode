#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger **data;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;

-(NSInteger)maxmialSquare;
-(NSInteger)maxmialSquare2;

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

-(NSInteger)maxmialSquare
{
    NSInteger i, j, k, len, max, count = 0;
    
    for (i = 0;i < self.row; i++) {
        count = 0;
        for (j = self.column - 1;j >= 0; j--) {
            if (self.data[i][j] == 1) {
                count++;
            } else {
                count = 0;
            }
            self.data[i][j] = count;
        }
    }
    
    NSLog(@"%@", self);
    
    max = 0;
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            len = self.data[i][j];
            if (len < max) {
                continue;
            }
            k = i, count = 0;
            while (k < i + len && k < self.row) {
                if (self.data[k][j] >= len) {
                    count++;
                    k++;
                } else {
                    len = self.data[k][j];
                }
            }
            if (count > max) {
                max = count;
            }
        }
    }
    
    return max * max;
}

-(NSInteger)maxmialSquare2
{
    NSInteger i, j, max = 0;

    for (i = 0;i < self.row; i++) {
        if (self.data[i][0] > max) {
            max = self.data[i][0];
        }
    }
    
    for (j = 0;j < self.column; j++) {
        if (self.data[0][j] > max) {
            max = self.data[0][j];
        }
    }
    
    for (i = 1;i < self.row; i++) {
        for (j = 1;j < self.column; j++) {
            if (self.data[i][j] == 1) {
                self.data[i][j] = MIN(MIN(self.data[i-1][j], self.data[i-1][j-1]), self.data[i][j-1]) + 1;
                if (self.data[i][j] > max) {
                    max = self.data[i][j];
                }
            }
        }
    }
    
    return max * max;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSInteger row = 4, column = 5;
        
        NSInteger **data = (NSInteger **)malloc(row * sizeof(NSInteger*));
        for (NSInteger i = 0;i < row; i++) {
            data[i] = (NSInteger *)malloc(column * sizeof(NSInteger));
        }
        
        data[0][0] = 1;
        data[0][1] = 0;
        data[0][2] = 1;
        data[0][3] = 0;
        data[0][4] = 0;
        
        data[1][0] = 1;
        data[1][1] = 0;
        data[1][2] = 1;
        data[1][3] = 1;
        data[1][4] = 1;
        
        data[2][0] = 1;
        data[2][1] = 1;
        data[2][2] = 1;
        data[2][3] = 1;
        data[2][4] = 1;
        
        data[3][0] = 1;
        data[3][1] = 0;
        data[3][2] = 0;
        data[3][3] = 1;
        data[3][4] = 0;
        
        TwoDimArray *data2 = [[TwoDimArray alloc] initWithData:data row:row column:column];
        NSLog(@"%ld", [data2 maxmialSquare2]);
    }
}

