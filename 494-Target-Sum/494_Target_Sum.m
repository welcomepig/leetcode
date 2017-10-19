#import <Foundation/Foundation.h>

NSInteger findTargetSumWaysPart(NSInteger *nums, NSInteger count, NSInteger S, NSInteger i) {
    if (i == count) return (S == 0) ? 1 : 0;
        
    return findTargetSumWaysPart(nums, count, S - nums[i], i + 1) + 
        findTargetSumWaysPart(nums, count, S + nums[i], i + 1);
}

NSInteger findTargetSumWays(NSInteger *nums, NSInteger count, NSInteger S) {
    return findTargetSumWaysPart(nums, count, S, 0);
}

int main(int argc, char * argv[]) {
    NSInteger n = 5;
    NSInteger *nums = (NSInteger *)malloc(sizeof(NSInteger) * n);
    nums[0] = nums[1] = nums[2] = nums[3] = nums[4] = 1;
    
    NSLog(@"%ld", findTargetSumWays(nums, n, 3));
    
    return 0;
}

