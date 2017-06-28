#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (Sqrt)

-(NSInteger)sqrt;
-(NSInteger)sqrtNewton;

@end

@implementation NSNumber (Sqrt)

-(NSInteger)sqrt
{
    NSInteger lo = 1;
    NSInteger hi = [self integerValue];
    NSInteger mid;
    
    while (lo < hi) {
        mid = lo + (hi - lo) / 2;
        
        if (mid * mid == [self integerValue]) {
            return mid;
        }
        
        if (mid * mid < [self integerValue]) {
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    }
    
    return -1;
}

-(NSInteger)sqrtNewton
{
    NSInteger r = [self integerValue];
    while (r * r > [self integerValue]) {
        r = (r + [self integerValue] / r) / 2;
    }
    return r;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%ld", [@(81) sqrtNewton]);
    }
}

