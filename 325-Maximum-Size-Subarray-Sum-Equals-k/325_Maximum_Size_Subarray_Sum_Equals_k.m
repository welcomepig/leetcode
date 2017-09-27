#import <Foundation/Foundation.h>

@interface NSArray (MaxSizeSubarray)

- (NSUInteger)maxSizeSubarrayEquals:(NSInteger)k;

@end

@implementation NSArray (MaxSizeSubarray)

- (NSUInteger)maxSizeSubarrayEquals:(NSInteger)k
{
    NSUInteger length = 0;
    NSInteger i, target, sum = 0;
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    
    hash[@(0)] = @(-1);
    for (i = 0;i < self.count; i++) {
        sum += [self[i] integerValue];

        target = sum - k;
        if (hash[@(target)]) {
            length = MAX(i - [hash[@(target)] integerValue], length);
        }
        if (!hash[@(sum)]) {
            hash[@(sum)] = @(i);
        }
    }
    
    return length;
}

@end

int main(int argc, char * argv[]) {
    NSArray *data1 = @[@(1), @(-1), @(5), @(-2), @(3)];
    NSLog(@"%ld", [data1 maxSizeSubarrayEquals:3]);
    
    NSArray *data2 = @[@(-2), @(-1), @(2), @(1)];
    NSLog(@"%ld", [data2 maxSizeSubarrayEquals:1]);
}
