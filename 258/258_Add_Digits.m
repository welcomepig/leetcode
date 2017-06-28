#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (AddDigits)

-(NSInteger)addDigits;
+(NSInteger)addDigitsWithValue:(NSInteger)value;

@end

@implementation NSNumber (AddDigits)

/* O(?) time */
-(NSInteger)addDigits
{
    return [NSNumber addDigitsWithValue:[self integerValue]];
}

+(NSInteger)addDigitsWithValue:(NSInteger)value
{
    NSInteger tmp = value;
    NSInteger sum = 0;
    
    while (tmp > 0) {
        sum = sum + tmp % 10;
        tmp = tmp / 10;
    }
    
    return (sum >= 10) ? [NSNumber addDigitsWithValue:sum] : sum;
}

/* O(1) time */
-(NSInteger)addDigitsConstantTime
{
    if ([self integerValue] == 0) {
        return 0;
    }
    return ([self integerValue] % 9 == 0) ? 9 : [self integerValue] % 9;
}
// https://en.wikipedia.org/wiki/Digital_root
// return 1 + (num - 1) % 9;

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSNumber *num = @(999);
        NSLog(@"%ld %ld", [num addDigits], [num addDigitsConstantTime]);
    }
}

