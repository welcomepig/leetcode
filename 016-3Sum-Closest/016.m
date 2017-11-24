#import <Foundation/Foundation.h>

NSUInteger threeSumCloser(NSArray *nums, NSInteger target)
{
    if (nums.count < 2) return 0;

    NSArray *sorted = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSInteger i, j, k, sum;
    NSInteger min = [sorted[0] integerValue] + [sorted[1] integerValue] + [sorted[2] integerValue];
    
    for (i = 0;i < sorted.count - 2; i++) {
        j = i + 1;
        k = sorted.count - 1;
        
        while (j < k) {
            sum = [sorted[i] integerValue] + [sorted[j] integerValue] + [sorted[k] integerValue];
            if (sum == target) {
                return target;
            }
            
            if (ABS(sum - target) < ABS(min - target)) {
                min = sum;
            }
            if (sum > target) {
                k--;
                while (j < k && [sorted[k+1] integerValue] == [sorted[k] integerValue]) k--;
            } else {
                j++;
                while (j < k && [sorted[j-1] integerValue] == [sorted[j] integerValue]) j++;
            }
        }
    }
    
    return min;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

