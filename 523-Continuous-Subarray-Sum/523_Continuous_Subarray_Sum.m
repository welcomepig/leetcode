#import <Foundation/Foundation.h>

/*BOOL continuousSubarraySum(NSArray *nums, NSUInteger k) {
    for (NSInteger i = 0;i < nums.count - 1; i++) {
        NSUInteger sum = [nums[i] integerValue];
        for (NSInteger j = i + 1;j < nums.count; j++) {
            sum += [nums[j] integerValue];
            if (k == 0) {
                if (sum == 0) return YES;
            } else if (sum % k == 0) {
                return YES;
            }
        }
    }
    
    return NO;
}*/

BOOL continuousSubarraySum(NSArray *nums, NSUInteger k) {
    NSMutableDictionary<NSNumber*, NSNumber*> *remainders = [NSMutableDictionary dictionary];
    NSUInteger r, sum = 0;
    
    remainders[@(0)] = @(-1);   // edge case: nums = [0, 0], k = 0
    for (NSInteger i = 0;i < nums.count; i++) {
        sum += [nums[i] integerValue];
        
        r = (k != 0) ? sum % k : sum;
        if (remainders[@(r)]) {
            if (i - [remainders[@(r)] integerValue] >= 2) return YES;
        } else {
            remainders[@(r)] = @(i);
        }
    }

    return NO;
}

int main(int argc, char * argv[]) {
    NSLog(@"%d", continuousSubarraySum(@[@(0), @(0)], 0));
    NSLog(@"%d", continuousSubarraySum(@[@(0)], 0));
    NSLog(@"%d", continuousSubarraySum(@[@(23), @(2), @(4), @(6), @(7)], 6));
    return 0;
}

