#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (KthLargestElement)

-(NSInteger)kthLargestElementSort:(NSInteger)k;
-(NSInteger)kthLargestElementSA:(NSInteger)k;

@end

@implementation NSMutableArray (KthLargestElement)

/* O(nlogn) running time + O(1) memory if reuse original array */
-(NSInteger)kthLargestElementSort:(NSInteger)k
{
    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    return [sorted[self.count - k] integerValue];
}

/* O(N) best case / O(N^2) worst case running time + O(1) memory */
-(NSInteger)kthLargestElementSA:(NSInteger)k
{
    NSInteger ki = self.count - k;
    NSInteger lo = 0;
    NSInteger hi = self.count - 1;
    
    while (lo <= hi) {
        NSInteger idx = [self partition:lo hi:hi];
        if (ki == idx) {
            break;
        }
        if (ki > idx) {
            lo = idx + 1;
        } else if (ki < idx) {
            hi = idx - 1;
        }
    }
    
    return [self[ki] integerValue];
}

-(NSInteger)partition:(NSInteger)lo hi:(NSInteger)hi
{
    NSInteger i = lo + 1;
    NSInteger j = hi;
    NSInteger pivot = [self[lo] integerValue];
    
    while (true) {
        while (i < hi && [self[i] integerValue] < pivot) i++;
        while (j > lo && [self[j] integerValue] > pivot) j--;
        if (i >= j) {
            break;
        }
        [self swap:i j:j];
    }
    
    // move pivot to jth position
    [self swap:lo j:j];
    
    return j;
}

-(void)swap:(NSInteger)i j:(NSInteger)j
{
    id tmp = self[j];
    self[j] = self[i];
    self[i] = tmp;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableArray *data = [NSMutableArray arrayWithArray:@[@(3), @(2), @(1), @(5), @(6), @(4)]];
        //NSLog(@"%ld", [data kthLargestElementSort:2]);
        NSLog(@"%ld", [data kthLargestElementSA:2]);
    }
}

