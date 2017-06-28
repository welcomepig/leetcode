#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (MergeSortedArray)

- (void)mergeAscPart;
- (BOOL)findAndMergeTwoAscPart;

@end
    
@implementation NSMutableArray (MergeSortedArray)
 
- (void)mergeAscPart
{
    while (1) {
        if ([self findAndMergeTwoAscPart]) {
            break;
        }
    }
}

//
- (BOOL)findAndMergeTwoAscPart
{
    BOOL isReachToEnd = YES;
    NSUInteger i, j, k;
    NSInteger p1_start, p1_end, p2_start, p2_end;
    NSInteger current, next;
    NSMutableArray *p1 = [NSMutableArray array];
    
    // find part
    i = p1_start = p2_start = 0;
    p1_end = p2_end = -1;
    current = [(NSNumber*)self[0] intValue];
    while (i + 1 < self.count) {
        next = [(NSNumber*)self[i + 1] intValue];
        
        if (next < current) {
            if (p1_end == -1) {
                // find first part
                p1_end = i;
                p2_start = i + 1;
                // point!
                [p1 addObject:self[i]];
            } else {
                // find second part
                p2_end = i;
                isReachToEnd = NO;
                break;
            }
        } else if (p1_end == -1) {
            // save p1's data to 
            [p1 addObject:self[i]];
        }
        
        current = next;
        i++;
    }
    p2_end = (isReachToEnd) ? self.count - 1 : p2_end;
    
    // merge
    i = p1_start;
    j = p2_start;
    k = 0;
    while (i <= p1_end && j <= p2_end) {
        if ([p1[i] intValue] < [self[j] intValue]) {
            self[k] = p1[i];
            i++;
        } else {
            self[k] = self[j];
            j++;
        }
        k++;
    }
    
    // insert p1 remain elements
    if (i <= p1_end) {
        [self replaceObjectsInRange:NSMakeRange(k, p1_end - i + 1) withObjectsFromArray:p1 range:NSMakeRange(i, p1_end - i + 1)];
    }
    
    return isReachToEnd;
}


@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *nums = @[@(2), @(8), @(13), @(1), @(3), @(10), @(5), @(7)];
        NSMutableArray *data = [NSMutableArray arrayWithArray:nums];
        
        [data mergeAscPart];
        NSLog(@"%@", data);
    }
}

