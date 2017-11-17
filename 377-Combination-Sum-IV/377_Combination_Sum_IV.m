#import <Foundation/Foundation.h>

// TTL
NSUInteger combinationSum(NSUInteger *nums, NSUInteger n, NSUInteger target) {
    if (target == 0) return 1;
    
    NSUInteger combinations = 0;
    
    for (NSInteger i = 0;i < n; i++) {
        if (nums[i] <= target) {
            combinations += combinationSum(nums, n, target - nums[i]);
        }
    }
    
    return combinations;
}

NSUInteger combinationSumDP(NSUInteger *nums, NSUInteger n, NSUInteger target) {
    if (target == 0) return 1;

    NSUInteger dp[target + 1];
     
    dp[0] = 1;
    for (NSInteger i = 1;i <= target; i++) {
        dp[i] = 0;
    }
    
    for (NSInteger i = 1;i <= target; i++) {
        for (NSInteger j = 0;j < n; j++) {
            if (nums[j] <= i) {
                dp[i] += dp[i - nums[j]];
            }
        }
    }
    
    return dp[target];
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSUInteger n = 3;
        NSUInteger *nums = (NSUInteger *)malloc(sizeof(NSUInteger) * n);
        
        nums[0] = 1;
        nums[1] = 2;
        nums[2] = 3;
        NSLog(@"%lu", combinationSumDP(nums, n, 4));
    }
}

