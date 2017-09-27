#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (MaximumSizeSubarray)

-(NSArray*)minimumSizeSubarray:(NSInteger)target;
-(NSArray*)minimumSizeSubarrayBSearch:(NSInteger)target;

@end

@implementation NSArray (MaximumSizeSubarray)

#pragma mark - O(n)

-(NSArray*)minimumSizeSubarray:(NSInteger)target
{
    NSInteger i, j, len, sum, mini, min = self.count + 1;
    
    i = 0;
    sum = 0;
    for (j = 0;j < self.count; j++) {
        sum = sum + [self[j] integerValue];
        
        while (sum >= target) {
            len = j - i + 1;
            if (len < min) {
                mini = i;
                min = len;
            }
            sum = sum - [self[i++] integerValue];
        }
    }
    
    return (min == self.count + 1) ? nil : [self subarrayWithRange:NSMakeRange(mini, min)];
}

#pragma mark - O(nlogn)

-(NSArray*)minimumSizeSubarrayBSearch:(NSInteger)target
{
    NSInteger i, j, sum, valueToFind, mini, min = self.count + 1;
    NSMutableArray *sums = [NSMutableArray array];
    
    sum = 0;
    for (i = 0;i < self.count; i++) {
        sum = sum + [self[i] integerValue];
        valueToFind = sum - target;
        
        if (sums.count > 0 && [sums[0] integerValue] <= valueToFind) {
            j = [self bsearch:0 hi:(i - 1) sums:[sums copy] target:valueToFind];
            if (i - j < min) {
                min = i - j;
                mini = j + 1;
            }
        }
        
        [sums addObject:@(sum)];
    }
    
    return (min == self.count + 1) ? nil : [self subarrayWithRange:NSMakeRange(mini, min)];
}

-(NSInteger)bsearch:(NSInteger)lo hi:(NSInteger)hi sums:(NSArray*)sums target:(NSInteger)target
{
    NSInteger mid;
    
    while (lo <= hi) {
        mid = lo + (hi - lo)/2;
        if ([sums[mid] integerValue] < target) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    return lo;
}

#pragma mark - O(nlogn)

- (NSUInteger)minSizeSubarraySumLogN:(NSInteger)s
{
    if (self.count == 0) return 0;
        
    NSMutableArray *tsums = [NSMutableArray array];
    NSUInteger length = self.count + 2;
    NSInteger i, j;
    
    tsums[0] = @(0);
    for (i = 1;i <= self.count; i++) {
        tsums[i] = @([tsums[i-1] integerValue] + [self[i-1] integerValue]);
    }
    NSArray *sums = [tsums copy];
    
    for (i = 0;i <= self.count; i++) {
        j = [self binarySearch:sums target:([sums[i] integerValue] + s) lo:(i+1) hi:self.count];
        if (j == self.count + 1) break;
        length = MIN(j - i, length);
    }
    
    return (length == self.count + 2) ? 0 : length;
}

- (NSInteger)binarySearch:(NSArray*)sums target:(NSInteger)target lo:(NSInteger)lo hi:(NSInteger)hi
{
    NSInteger mid;
    
    while (lo <= hi) {
        mid = lo + (hi - lo) / 2;
        
        if ([sums[mid] integerValue] >= target) {
            hi = mid - 1;
        } else {
            lo = mid + 1;
        }
    }

    return lo;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data1 = @[@(2), @(3), @(1), @(2), @(4), @(3)];
        NSLog(@"%@", [data1 minimumSizeSubarrayBSearch:7]);
    }
}

