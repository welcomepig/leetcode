#import <Foundation/Foundation.h>

@interface NSMutableArray (KthLargestElement)

- (NSInteger)kthLargest:(NSUInteger)k;

@end

@implementation NSMutableArray (KthLargestElement)

- (NSInteger)partition:(NSInteger)lo hi:(NSInteger)hi
{
    if (lo >= hi) return lo;
    
    NSInteger i = lo;
    NSInteger j = hi - 1;
    NSInteger pivot = [self[hi] integerValue];
    
    while (i <= j) {
        if ([self[i] integerValue] < pivot) {
            i++;
        } else if ([self[i] integerValue] > pivot) {
            [self exchangeObjectAtIndex:i
                      withObjectAtIndex:j];
            j--;
        }
    }
    [self exchangeObjectAtIndex:i withObjectAtIndex:hi];
    
    return i;
}

#pragma mark - Iterative

- (NSInteger)kthSmallestIndex:(NSUInteger)k
{ 
    NSInteger i;
    NSInteger lo = 0;
    NSInteger hi = self.count - 1;
    
    while (lo < hi) {
        // 1. partition
        i = [self partition:lo hi:hi];
        
        // 2. compare
        if (k == i) return [self[k] integerValue];
        if (k > i) {
            lo = i + 1;
        } else {
            hi = i - 1;
        }
    }
    
    return [self[k] integerValue];
}

#pragma mark - Recursive

- (NSInteger)kthSmallestIndexRecursive:(NSUInteger)k
{ 
    NSInteger lo = 0;
    NSInteger hi = self.count - 1;
    NSInteger idx = [self partition:lo hi:hi];

    while (k != idx) {
        if (k > idx) {
            lo = idx + 1;
        } else {
            hi = idx - 1;
        }
        idx = [self partition:lo hi:hi];
    }
    
    return [self[idx] integerValue];
}

- (NSInteger)kthLargest:(NSUInteger)k
{
    NSAssert(k <= self.count, @"k is invalid value");
    return [self kthSmallestIndex:(self.count - k)];
}

@end

int main(int argc, char * argv[]) {
    NSMutableArray *data = [NSMutableArray arrayWithArray:@[@(3), @(2), @(1), @(5), @(6), @(4)]];
    NSLog(@"%ld", [data kthLargest:2]);
}
