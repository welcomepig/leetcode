#import <Foundation/Foundation.h>

NSInteger searchInRotatedArray(NSMutableArray<NSNumber*> *nums, NSInteger target){
    NSInteger lo = 0;
    NSInteger hi = nums.count - 1;
    NSInteger mid;
    
    while (lo <= hi) {
        mid = lo + (hi - lo)/2;
        if ([nums[mid] integerValue] == target) return mid;
        if (target > [nums[mid] integerValue]) {
            if ([nums[lo] integerValue] > [nums[mid] integerValue] && target >= [nums[lo] integerValue]) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        } else {
            if ([nums[hi] integerValue] < [nums[mid] integerValue] && target <= [nums[hi] integerValue]) {
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }
    }
    
    return -1;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

