#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSDArray : NSObject

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign, readonly) NSUInteger row;
@property (nonatomic, assign, readonly) NSUInteger column;

-(void)insertRow:(NSArray*)row;
-(NSUInteger)maxSquareArea;

@end
    
@implementation NSDArray
    
-(instancetype)init
{
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
    }
    return self;
}
    
-(NSUInteger)row
{
    return self.data.count;
}

-(NSUInteger)column
{
    if (self.data.count > 0) {
        return ((NSArray *)self.data[0]).count;
    }
    return 0;
}

-(void)insertRow:(NSArray*)row
{
    [self.data addObject:row];
}

-(NSObject*)valueAt:(NSInteger)i j:(NSInteger)j
{
    if (self.data.count > i) {
        NSArray *row = self.data[i];
        return row[j];
    }
    return nil;
}

// worst method: O(n^5)
-(NSUInteger)maxSquareArea
{
    NSUInteger max = 0;
    bool isSquare;
    
    for (int i = 0;i < self.row; i++) {
        for (int j = 0;j < self.column; j++) {
            for (int len = 1; i + len <= self.row && j + len <= self.column; len++) {
                isSquare = true;
                for (int m = i;m < i + len; m++) {
                    for (int n = j;n < j + len; n++) {
                        NSNumber *num = (NSNumber*)[self valueAt:m j:n];
                        if ([num intValue] == 0) {
                            isSquare = false;
                            break;
                        }
                    }
                    if (!isSquare) {
                        break;
                    }
                }
                
                if (isSquare && len > max) {
                    max = len;
                }
            }
        }
    }
    
    return max * max;
}

// better method: O(W * H * H) space O(W * H) 
-(NSUInteger)maxSquareArea2
{
    NSDArray *widths = [[NSDArray alloc] init];
    NSUInteger sum, max = 0;
    
    for (int i = 0;i < self.row ; i++) {
        sum = 0;
        NSMutableArray *rwidths = [NSMutableArray array];
        for (int j = self.column - 1;j >= 0; j--) {
            NSNumber *num = (NSNumber*)[self valueAt:i j:j];
            sum = ([num intValue] == 0) ? 0 : sum + 1;
            [rwidths insertObject:@(sum) atIndex:0];
        }
        [widths insertRow:[rwidths copy]];
    }
    
    NSInteger len, w, h, maxw;
    for (int i = 0;i < self.row; i++) {
        for (int j = 0;j < self.column; j++) {
            maxw = MAX(self.row, self.column) + 1;
            for (h = 1;h <= maxw && (i + h - 1 < self.row); h++) {
                w = [(NSNumber*)[widths valueAt:(i + h - 1) j:j] intValue];
                if (w == 0) {
                    break;
                }
                maxw = MIN(maxw, w);
            }
            len = MIN(maxw, h - 1);
            if (len > max) {
                max = len;
            }
        }
    }
    
    return max * max;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSDArray *d = [[NSDArray alloc] init];
        [d insertRow:@[@(1), @(0), @(1), @(0), @(0), @(0)]];
        [d insertRow:@[@(1), @(0), @(1), @(1), @(1), @(1)]];
        [d insertRow:@[@(1), @(1), @(1), @(1), @(1), @(0)]];
        [d insertRow:@[@(1), @(0), @(1), @(0), @(0), @(0)]];
        
        //NSLog(@"%lu", [d maxSquareArea]);
        NSLog(@"%lu", [d maxSquareArea2]);
    }
}

