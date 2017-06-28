#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (HammingDistance)

- (NSInteger)hammingDistance:(NSNumber)num;

@end

@implementation NSNumber (HammingDistance)

- (NSInteger)hammingDistance:(NSNumber)num
{
    NSInteger valuea = [self integerValue];
    NSInteger valueb = [num integerValue];

    NSInteger diff = valuea ^ valueb;
    NSInteger dist = 0;

    while (diff > 1) {
        if (diff & 1) {
            dist++;
        }
        diff = diff >> 1;
    }

    return dist;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%ld", [@(4) hammingDistance:@(1)]);
    }
}

