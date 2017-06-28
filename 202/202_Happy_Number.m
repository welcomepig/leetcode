#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (HappyNumber)

-(BOOL)isHappyNumber;

@end

@implementation NSNumber (HappyNumber)

+(NSInteger)digitsSquareSum:(NSInteger)num
{
    NSInteger sum = 0;
    NSInteger tmp = num;
    
    while (tmp != 0) {
        sum = sum + (tmp % 10) * (tmp % 10);
        tmp = tmp / 10;
    }
    
    return sum;
}

-(BOOL)isHappyNumber
{
    NSMutableSet *set = [NSMutableSet set];
    NSInteger value = [self integerValue];
    if (value < 0) {
        return NO;
    }
    
    while (![set containsObject:@(value)]) {
        [set addObject:@(value)];
        value = [NSNumber digitsSquareSum:value];
        if (value == 1) {
            return YES;
        }
    }
    
    return NO;
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSNumber *num = @(7);
        NSLog(@"%d", [num isHappyNumber]);
    }
}

