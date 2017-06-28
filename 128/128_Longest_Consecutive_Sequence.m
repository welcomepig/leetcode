#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (LCS)

-(NSInteger)longestConsecutiveSequence;

@end

@implementation NSArray (LCS)

-(NSInteger)longestConsecutiveSequence
{
    NSInteger max = 0;
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    
    for (NSNumber *num in self) {
        if (hash[num]) {                // to skip duplicate
            continue;
        }
        NSInteger value = [num integerValue];
        NSInteger left = hash[@(value-1)] ? [hash[@(value-1)] integerValue] : 0;
        NSInteger right = hash[@(value+1)] ? [hash[@(value+1)] integerValue] : 0;
        NSInteger sum = right + left + 1;
    
        hash[@(value)] = @(sum);        // to skip duplicate
        hash[@(value-left)] = @(sum);
        hash[@(value+right)] = @(sum);
        max = MAX(sum, max);
    }
    
    return max;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(100), @(4), @(200), @(1), @(3), @(2), @(4), @(2)];
        NSLog(@"%ld", [data longestConsecutiveSequence]);
    }
}
