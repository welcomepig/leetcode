#import <Foundation/Foundation.h>

// Task is Capital letters A to Z
NSUInteger leastInterval(NSArray *tasks, NSUInteger n)
{
    if (tasks.count == 0) return 0;
    
    NSMutableDictionary *counts = [NSMutableDictionary dictionary];
    for (id task in tasks) {
        if (!counts[task]) {
            counts[task] = @(0);
        }
        counts[task] = @([counts[task] integerValue] + 1);
    }
    
    NSArray *sorted = [counts.allValues sortedArrayUsingSelector:@selector(compare:)];
    NSInteger max = [sorted[sorted.count - 1] integerValue];
    NSInteger left = (max - 1) * (n - 1);
    
    for (NSInteger i = sorted.count - 2;i >= 1; i--) {
        left = left - (([sorted[i] integerValue] == max) ? [sorted[i] integerValue] - 1 : [sorted[i] integerValue]);
        if (left <= 0) return tasks.count;
    }
    
    return tasks.count + left;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%ld", leastInterval(@[@('A'), @('A'), @('A')], 2));
        NSLog(@"%ld", leastInterval(@[@('A'), @('A'), @('A'), @('B'), @('B'), @('B')], 2));
    }
}

