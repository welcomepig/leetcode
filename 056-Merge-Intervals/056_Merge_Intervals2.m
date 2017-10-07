#import <Foundation/Foundation.h>

NSArray* mergeIntervals(NSArray *intervals) 
{
    if (intervals.count < 1) return intervals;
    
    NSMutableArray *result = [NSMutableArray array];
    NSArray *sorted = [intervals sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSRange ra = [a rangeValue];
        NSRange rb = [b rangeValue];
        
        if (ra.location < rb.location) {
            return NSOrderedAscending;
        } else if (ra.location > rb.location) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    NSRange r1 = [sorted[0] rangeValue];
    NSRange r2;
    for (NSInteger i = 1;i < sorted.count; i++) {
        r2 = [sorted[i] rangeValue];
        if (r1.location + r1.length >= r2.location) {
            r1 = NSUnionRange(r1, r2);
        } else {
            [result addObject:[NSValue valueWithRange:r1]];
            r1 = r2;
        }
    }
    [result addObject:[NSValue valueWithRange:r1]];
    
    return [result copy];
}

int main(int argc, char * argv[]) {
}
