#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (MergeSortedArray)

+ (void)mergeSortedArray:(NSMutableArray*)nums1 n:(NSUInteger)n nums2:(NSArray*)nums2 m:(NSUInteger)m;

@end
    
@implementation NSMutableArray (MergeSortedArray)
/*
+ (void)mergeSortedArray:(NSMutableArray*)nums1 n:(NSUInteger)n nums2:(NSArray*)nums2 m:(NSUInteger)m
{   
    // 1. point!! reverse fill array
    // 0 => m - 1, 1 => m .... i => m + i - 1
    NSInteger i, j, k;
    for (i = n - 1;i >= 0; i--) {
        nums1[m + i] = nums1[i];
    }
    NSLog(@"%@", nums1);
    
    // 2.
    i = j = k = 0;
    while (i < n && j < m) {
        if ([nums1[m + i] intValue] < [nums2[j] intValue]) {
            nums1[k] = nums1[m + i];
            i++;
        } else {
            nums1[k] = nums2[j];
            j++;
        }
        k++;
    }
    
    // append nums2
    if (j < m) {
        [nums1 replaceObjectsInRange:NSMakeRange(k, m - j) withObjectsFromArray:nums2 range:NSMakeRange(j, m - j)];
    }
}*/
+ (void)mergeSortedArray:(NSMutableArray*)nums1 n:(NSUInteger)n nums2:(NSArray*)nums2 m:(NSUInteger)m
{   
    // 1. point!! reverse fill array
    // 0 => m - 1, 1 => m .... i => m + i - 1
    NSInteger i = n - 1, j = m - 1, k = m + n - 1;
    
    // 2.
    while (i >= 0 && j >= 0) {
        if ([nums1[i] intValue] > [nums2[j] intValue]) {
            nums1[k] = nums1[i];
            i--;
        } else {
            nums1[k] = nums2[j];
            j--;
        }
        k--;
    }
    
    // append nums2
    if (j >= 0) {
        [nums1 replaceObjectsInRange:NSMakeRange(0, j+1) withObjectsFromArray:nums2 range:NSMakeRange(0, j+1)];
    }
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *nums2 = @[@(1), @(3), @(7)];
        NSArray *nums1 = @[@(2), @(4), @(5), @(8), @(9), @(13)];
        NSUInteger n = nums1.count;
        NSUInteger m = nums2.count;
        
        
        NSMutableArray *data1 = [NSMutableArray array];
        for (int i = 0;i < n; i++) {
            [data1 addObject:nums1[i]];
        }
        for (int i = 0;i < m; i++) {
            [data1 addObject:@(0)];
        }
        NSLog(@"%@", nums1);
        NSLog(@"%@", nums2);
        
        [NSMutableArray mergeSortedArray:data1 n:n nums2:nums2 m:m];
        NSLog(@"%@", data1);
    }
}

