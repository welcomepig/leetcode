#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger **data;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;

-(NSInteger)maxmialRectangle;

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

-(NSInteger)maxmialRectangle
{
    NSInteger i, j, h, w, area, count;
    
    for (i = 0;i < self.row; i++) {
        count = 0;
        for (j = 0;j < self.column; j++) {
            if (self.data[i][j] == 1) {
                count++;
                self.data[i][j] = count;
            } else {
                count = 0;
            }
        }
    }
    
    area = 0;
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            w = NSIntegerMax;
            for (h = 1; i - h + 1 >= 0; h++) {
                if (self.data[i - h + 1][j] == 0) break;
                w = MIN(w, self.data[i - h + 1][j]);
                area = MAX(area, w * h);
            }
        }
    }
    
    return area;
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
        NSLog(@"%ld", [data2 maxmialRectangle]);
    }
}

