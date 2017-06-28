#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (UglyNumber)

-(BOOL)isUglyNumber;

@end

@implementation NSNumber (UglyNumber)

-(BOOL)isUglyNumber
{
    NSInteger value = [self integerValue];
    if (value <= 1) {
        return YES;
    }
    
    while (value % 2 == 0) value = value / 2;
    while (value % 3 == 0) value = value / 3;
    while (value % 5 == 0) value = value / 5;
    
    return (value == 1);
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSNumber *num = @(14);
        NSLog(@"%d", [num isUglyNumber]);
    }
}

