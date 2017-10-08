#import <Foundation/Foundation.h>

@interface NSMutableArray (RotatedSorted)

- (NSInteger)searchValue:(NSInteger)value;

@end

@implementation NSMutableArray (RotatedSorted)

- (NSInteger)searchValue:(NSInteger)target
{
    NSInteger lo = 0;
    NSInteger hi = self.count - 1;
    NSInteger med, mval;
    
    while (lo <= hi) {
        med = lo + (hi - lo)/2;
        mval = [self[med] integerValue];
        
        if (mval == target) return med;
        if (mval >= [self[lo] integerValue]) {
            if (target < mval && target >= [self[lo] integerValue]) {
                hi = med - 1;
            } else {
                lo = med + 1;
            }
        }
        
        if (mval <= [self[hi] integerValue]) {
            if (target > mval && target <= [self[hi] integerValue]) {
                lo = med + 1;
            } else {
                hi = med - 1;
            }
        }
    }
    
    return -1;
}

@end

int main(int argc, char * argv[]) {
    NSMutableArray *data1 = [@[@(4), @(5), @(1), @(2), @(3)] mutableCopy];
    NSLog(@"%ld", [data1 searchValue:1]);
    NSLog(@"%ld", [data1 searchValue:0]);
    
    NSMutableArray *data2 = [@[@(4), @(5), @(6), @(7), @(8), @(1), @(2), @(3)] mutableCopy];
    NSLog(@"%ld", [data2 searchValue:8]);
}
