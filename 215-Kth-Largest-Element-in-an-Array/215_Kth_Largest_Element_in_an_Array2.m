#import <Foundation/Foundation.h>

NSInteger partition(NSMutableArray<NSNumber*> *nums, NSInteger lo, NSInteger hi) {
    NSInteger i, j, pivot;
    
    i = lo; j = hi - 1; pivot = [nums[hi] integerValue];
    
    while (i <= j) {
        if ([nums[i] integerValue] > pivot) {
            [nums exchangeObjectAtIndex:i withObjectAtIndex:j];
            j--;
        } else if ([nums[i] integerValue] < pivot) {
            i++;
        }
    }
    [nums exchangeObjectAtIndex:i withObjectAtIndex:hi];
    
    return i;
}

NSInteger kthSmallestElement(NSMutableArray<NSNumber*> *nums, NSUInteger k){
    NSInteger lo = 0;
    NSInteger hi = nums.count - 1;
    NSUInteger p = partition(nums, lo, hi);
    
    while (p != k) {
        if (p == k) break;
        if (p < k) {
            lo = p + 1;
        } else {
            hi = p - 1;
        }
        p = partition(nums, lo, hi);
    }
    return [nums[k] integerValue];
}

NSInteger kthLargestElement(NSMutableArray<NSNumber*> *nums, NSUInteger k){
    return kthSmallestElement(nums, nums.count - k);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSMutableArray *data = [NSMutableArray arrayWithArray:@[@(3), @(2), @(1), @(5), @(6), @(4)]];
        NSLog(@"%ld", kthLargestElement(data, 2));
    }
}

