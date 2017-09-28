#import <Foundation/Foundation.h>

@interface TaskScheduler : NSObject

+ (NSUInteger)leastInterval:(NSArray*)tasks n:(NSUInteger)n;

@end

@implementation TaskScheduler

+ (NSUInteger)leastInterval:(NSArray*)tasks n:(NSUInteger)n
{
    if (n == 0 || tasks.count == 0) return 0;

    NSMutableArray *c = [NSMutableArray arrayWithCapacity:26];
    NSInteger i, val;
    
    for (i = 0;i < 26; i++) {
        [c addObject:@(0)];
    }
    
    for (id task in tasks) {
        i = [task charValue] - 'A';
        val = [c[i] integerValue] + 1;
        c[i] = @(val);
    }
    
    NSArray *sorted = [c sortedArrayUsingSelector:@selector(compare:)];
    i = sorted.count - 1;
    
    while (i >= 0 && [sorted[i] integerValue] == [sorted[sorted.count - 1] integerValue]) i--;
    
    return MAX(tasks.count, ([sorted[sorted.count - 1] integerValue] - 1) * (n + 1) + sorted.count - 1 - i);
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%ld", [TaskScheduler leastInterval:@[@('A'), @('A'), @('A'), @('B'), @('B'), @('B')] n:2]);
}

