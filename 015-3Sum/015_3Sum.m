#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (ThreeSum)

-(NSArray*)threeSum;

@end

@implementation NSArray (SearchRotatedSorted)

-(NSArray*)threeSum
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    NSInteger i, j, k, target, sum;
    
    for (i = 0;i < sorted.count - 2; i++) {
        if (i > 0 && [sorted[i - 1] integerValue] == [sorted[i] integerValue]) {
            continue;
        }
        
        j = i + 1;
        k = sorted.count - 1;
        target = -[sorted[i] integerValue];
        while (j < k) {
            sum = [sorted[j] integerValue] + [sorted[k] integerValue];
            if (sum == target) {
                [result addObject:@[sorted[i], sorted[j], sorted[k]]];
                j++; k--;
                while (j < k && [sorted[j-1] integerValue] == [sorted[j] integerValue]) j++;
                while (j < k && [sorted[k] integerValue] == [sorted[k+1] integerValue]) k--;
            } else if (sum < target) {
                j++;
            } else {
                k--;
            }
        }
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(-1), @(0), @(1), @(2), @(-1), @(-4)];
        NSLog(@"%@", [data threeSum]);
    }
}

