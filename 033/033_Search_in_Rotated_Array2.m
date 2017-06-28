#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (SearchRotatedSorted)

-(NSInteger)searchRotatedInSortedArray:(NSInteger)target;

@end

@implementation NSArray (SearchRotatedSorted)

-(NSInteger)searchRotatedInSortedArray:(NSInteger)target from:(NSInteger)lo to:(NSInteger)hi
{
    NSInteger mid = lo + (hi - lo) / 2;
    NSInteger hvalue = [self[lo] integerValue];
    NSInteger tvalue = [self[hi] integerValue];
    NSInteger mvalue = [self[mid] integerValue];
    
    if (mvalue == target) {
        return mid;
    }
    
    if (target > mvalue) {
        if (target > tvalue) {
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    } else {
        if (target < hvalue) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }
    
    return [self searchRotatedInSortedArray:target from:lo to:hi];
}

-(NSInteger)searchRotatedInSortedArray:(NSInteger)target
{
    return [self searchRotatedInSortedArray:target from:0 to:(self.count - 1)];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(4), @(5), @(6), @(7), @(0), @(1), @(2)];
        for (NSNumber *num in data) {
            NSLog(@"%ld", [data searchRotatedInSortedArray:[num integerValue]]);
        }
    }
}

