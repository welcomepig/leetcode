#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (HIndexII)

-(NSInteger)hindex;

@end

@implementation NSArray (HIndexII)

-(NSInteger)hindex
{
    NSInteger lo = 0;
    NSInteger hi = self.count - 1;
    NSInteger mid, val, num;
    
    while (lo <= hi) {
        mid = lo + (hi - lo)/2;
        num = self.count - mid;
        val = [self[mid] integerValue];
        
        if (val == num) {
            return num;
        }
        
        if (val < num) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }
    
    return (self.count - hi + 1);
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *indexes = @[@(3), @(0), @(6), @(1), @(5)];
        NSArray *sorted = [indexes sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"%ld", [sorted hindex]);
    }
}

