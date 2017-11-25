#import <Foundation/Foundation.h>

BOOL checkSubarraySum(NSArray<NSNumber*> *nums, NSUInteger k){
    if (nums.count < 2) return NO;
    for (NSUInteger i = 0; i < nums.count - 1; i++) {
        if ([nums[i] integerValue] == 0 && [nums[i + 1] integerValue] == 0) return YES;
    }
    if (k == 0) return NO;
    
    NSMutableDictionary *sums = [NSMutableDictionary dictionary];
    NSUInteger sum = 0;
    
    sums[@(0)] = @(-1);
    for (NSUInteger i = 0;i < nums.count; i++) {
        sum += [nums[i] integerValue];
        
        for (NSUInteger j = (sum/k) * k; j >= k; j -= k) {
            if (sums[@(sum - j)] && (i - [sums[@(sum - j)] integerValue]) >= 2) {
                return YES;
            }
        }
        
        sums[@(sum)] = @(i);
    }
    
    return NO;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%d", checkSubarraySum(@[@(0), @(0)], 0));
        NSLog(@"%d", checkSubarraySum(@[@(0)], 0));
        NSLog(@"%d", checkSubarraySum(@[@(23), @(2), @(4), @(6), @(7)], 6));
    }
}

