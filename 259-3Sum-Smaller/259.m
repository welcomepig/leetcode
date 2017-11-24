#import <Foundation/Foundation.h>

NSUInteger threeSumSmaller(NSArray *nums, NSInteger target)
{
    if (nums.count < 2) return 0;

    NSUInteger count = 0;
    NSArray *sorted = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSInteger i, j, k, sum;
    
    for (i = 0;i < sorted.count - 2; i++) {
        j = i + 1;
        k = sorted.count - 1;
        
        while (j < k) {
            sum = [sorted[i] integerValue] + [sorted[j] integerValue] + [sorted[k] integerValue];
            if (sum < target) {
                count += k - j;
                j++;
            } else {
                k--;
            }
        }
    }
    
    return count;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

