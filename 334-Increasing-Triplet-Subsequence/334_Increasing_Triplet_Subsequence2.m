#import <Foundation/Foundation.h>

BOOL increasingTripletSubsequence(NSInteger *nums, NSUInteger n) {
    if (n < 3) return NO;
    
    NSInteger ni = NSIntegerMax;
    NSInteger nj = NSIntegerMax;

    for (NSInteger i = 0;i < n; i++) {
        if (nums[i] < ni) {
            ni = nums[i];
        } else if (nums[i] > ni && nums[i] < nj) {
            nj = nums[i];
        } else if (nums[i] > nj) {
            return YES;
        }
    }
    
    return NO;
}

int main(int argc, char * argv[]) {
    NSUInteger n = 5;
    NSInteger *nums = (NSInteger *)malloc(sizeof(NSInteger) * n);
    nums[0] = 6; nums[1] = 7; nums[2] = 0; nums[3] = 1; nums[4] = 5;
    NSLog(@"%d", increasingTripletSubsequence(nums, n));
    return 0;
}

