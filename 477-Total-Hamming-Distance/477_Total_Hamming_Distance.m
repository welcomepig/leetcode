#import <Foundation/Foundation.h>

NSUInteger totalHammingDistance(NSUInteger *nums, NSUInteger n) {
    NSUInteger bit1Count, bits = 0;
    
    for (NSInteger i = 0;i <= 30; i++) {
        bit1Count = 0;
        for (NSInteger j = 0;j < n; j++) {
            bit1Count += nums[j] >> i & 1;
        }
        bits += bit1Count * (n - bit1Count);
    }
    
    return bits;
}


int main(int argc, char * argv[]) {
    NSUInteger n = 3;
    NSUInteger *nums = (NSUInteger*)malloc(sizeof(NSUInteger) * n);
    nums[0] = 4;
    nums[1] = 14;
    nums[2] = 2;
    
    NSLog(@"%ld", totalHammingDistance(nums, 3));
    return 0;
}

