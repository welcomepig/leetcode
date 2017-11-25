#import <Foundation/Foundation.h>

NSUInteger subarraySumEqualsK(NSArray<NSNumber*> *nums, NSInteger k){
    NSUInteger count = 0;
    NSMutableDictionary *sums = [NSMutableDictionary dictionary];
    NSInteger sum, target;
    
    sum = 0;
    sums[@(0)] = @(1);
    for (NSNumber *num in nums) {
        sum += [num integerValue];
        target = sum - k;
        
        if (sums[@(target)]) count += [sums[@(target)] integerValue];
        if (!sums[@(sum)]) sums[@(sum)] = @(0);
        sums[@(sum)] = @([sums[@(sum)] integerValue] + 1);
    }
    
    return count;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {

    }
}

