#import <Foundation/Foundation.h>

@interface NSArray (TwoSum)

- (BOOL)hasTwoSumNoSpace:(NSInteger)target;
- (NSArray*)twoSumNoSpace:(NSInteger)target;
- (NSArray*)twoSum:(NSInteger)target;

@end

@implementation NSArray (TwoSum)

- (BOOL)hasTwoSumNoSpace:(NSInteger)target
{
    NSInteger i, j;
    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    
    i = 0;
    j = self.count - 1;
    while (i < j) {
        if ([self[i] integerValue] + [self[j] integerValue] == target) return YES;
        if ([self[i] integerValue] + [self[j] integerValue] < target) {
            i++;
        } else {
            j--;
        }
    }
    
    return NO;
}

- (NSArray*)twoSumNoSpace:(NSInteger)target
{
    NSInteger target_to_find;
    
    for (NSInteger i = 0;i < self.count; i++) {
        target_to_find = target - [self[i] integerValue];
        for (NSInteger j = 0;j < self.count; j++) {
            if ([self[j] integerValue] == target_to_find) {
                return @[@(i), @(j)];
            }
        }
    }
    
    return @[];
}

- (NSArray*)twoSum:(NSInteger)target
{
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    NSNumber *target_to_find;
    
    for (NSInteger i = 0;i < self.count; i++) {
        target_to_find = @(target - [self[i] integerValue]);
        if (map[target_to_find]) {
            return @[map[target_to_find], @(i)];
        }
        map[self[i]] = @(i);
    }
    
    return @[];
}

@end

int main(int argc, char * argv[]) {
    NSArray *data = @[@(1), @(-1), @(5), @(4), @(6)];
    NSLog(@"hasTwoSumNoSpace = %d", [data hasTwoSumNoSpace:7]);
    NSLog(@"twoSumNoSpace = %@", [data twoSumNoSpace:7]);
    NSLog(@"twoSum = %@", [data twoSum:7]);
}
