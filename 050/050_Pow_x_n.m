#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (Pow)

+(double)pow:(double)value exp:(NSInteger)exp;
-(double)pow:(NSInteger)exp;

@end
    
@implementation NSNumber (Pow)

// O(logn) recursive version
+(double)pow:(double)value exp:(NSInteger)exp
{
    // handle special case
    if (exp == 0) {
        return 1;
    }
    if (fabs(value - 0.0) < 0.0000001) return 0.0;
    if (fabs(value - 1.0) < 0.0000001) return 1.0;    
    
    if (exp < 0) {
        exp = -exp;
        value = 1 / value;
    }
    return (exp %2 == 0) ? 
        [NSNumber pow:(value * value) exp:(exp / 2)] : 
        value * [NSNumber pow:(value * value) exp:(exp / 2)];
}
/*
- (double)pow:(NSInteger)exp
{
    return [NSNumber pow:[self doubleValue] exp:exp];
}
*/
/*
// O(n) iterative vesion
-(double)pow:(NSInteger)exp
{
    if (exp == 0) {
        return 1;
    }
    
    double base = [self doubleValue];
    if (fabs(base - 0.0) < 0.0000001) return 0.0;
    if (fabs(base - 1.0) < 0.0000001) return 1.0; 
    
    if (exp < 0) {
        exp = -exp;
        base = 1 / base;
    }
    
    double result = 1;
    NSUInteger i;
    for (i = 0;i < exp; i++) {
        result = result * base;
    }
    
    return result;
}*/

// O(logn) iterative vesion 2 (faster)
-(double)pow:(NSInteger)exp
{
    if (exp == 0) {
        return 1;
    }

    double base = [self doubleValue];
    long n = exp;
    
    if (fabs(base - 0.0) < 0.0000001) return 0.0;
    if (fabs(base - 1.0) < 0.0000001) return 1.0; 
    
    if (n < 0) {
        n = -n;
        base = 1 / base;
    }
    
    double result = 1;
    while (n > 0) {
        
        if ((n & 1) == 1) {
            result = result * base;
        }
        base = base * base;
        n >>= 1;
    }
    
    return result;
}

@end

    
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSNumber *base = @(2);
        NSLog(@"%lf", [base pow:10]);
        NSLog(@"%lf", [base pow:-10]);
    }
}

