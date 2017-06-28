#import <Foundation/Foundation.h>
#import <stdio.h>

@interface Range : NSObject

+(NSArray*)mergeIntervals:(NSArray*)intervals;
/*+(BOOL)isIntersectRangeA:(NSInteger [2])a b:(NSInteger [2])b;*/
+(BOOL)isIntersectRangeA:(NSRange)a b:(NSRange)b;

@end

@implementation Range

+(NSArray*)mergeIntervals:(NSArray*)intervals
{
    NSMutableArray *vals = [intervals mutableCopy];
    NSInteger i, j;
    
    for (i = 0;i < vals.count; i++) {
        j = i + 1;
        while (j < vals.count) {
            if ([Range isIntersectRangeA:[vals[i] rangeValue] b:[vals[j] rangeValue]]) {
                NSRange newRange = NSUnionRange([vals[i] rangeValue], [vals[j] rangeValue]);
                vals[i] = [NSValue valueWithRange:newRange];
                [vals removeObjectAtIndex:j];
                continue;
            }
            j++;
        }
    }
    
    return [vals copy];
}

+(NSArray*)mergeIntervals2:(NSArray*)intervals
{
    if (intervals.count == 0) {
        return @[];
    }
    
    NSMutableArray *sorted = [[intervals sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSRange ra = [a rangeValue];
        NSRange rb = [b rangeValue];
        return [@(ra.location) compare:@(rb.location)];
    }] mutableCopy];
    
    NSInteger i = 1;
    NSRange current, prev = [sorted[0] rangeValue];
    while (i < sorted.count) {
        current = [sorted[i] rangeValue];
        if (prev.location + prev.length >= current.location) {
            prev = NSUnionRange(prev, current);
            sorted[i-1] = [NSValue valueWithRange:prev];
            [sorted removeObjectAtIndex:i];
            continue;
        }
        i++;
        prev = current;
    }

    return [sorted copy];
}

+(NSArray*)mergeIntervals3:(NSArray*)intervals
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *sorted = [intervals sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        NSRange ra = [a rangeValue];
        NSRange rb = [b rangeValue];
        return [@(ra.location) compare:@(rb.location)];
    }];
    
    NSInteger start = 0, end = -1;
    for (id obj in sorted) {
        NSRange range = [obj rangeValue];
        if (end == -1) {
            start = range.location;
            end = range.location + range.length;
            continue;
        }
        
        if (range.location <= end) {
            end = MAX(end, range.location + range.length - 1);
        } else {
            [result addObject:[NSValue valueWithRange:NSMakeRange(start, end - start + 1)]];
            start = range.location;
            end = range.location + range.length - 1;
        }
    }
    if (end != -1) {
        [result addObject:[NSValue valueWithRange:NSMakeRange(start, end - start + 1)]];
    }
    
    return [result copy];
}

+(NSArray*)insertInterval:(NSRange)interval sortedIntervals:(NSArray*)sortedIntervals
{
    NSMutableArray *result = [NSMutableArray array];
    NSRange range;
    NSInteger i;
    
    for (i = 0;i < sortedIntervals.count; i++) {
        range = [sortedIntervals[i] rangeValue];
        if (interval.location <= range.location + range.length - 1) {
            break;
        }
        [result addObject:sortedIntervals[i]];
    }
    
    NSInteger start = interval.location;
    NSInteger end = interval.location + interval.length - 1;
    for (;i < sortedIntervals.count; i++) {
        range = [sortedIntervals[i] rangeValue];
        if (range.location > interval.location + interval.length - 1) {
            break;
        }
        
        start = MIN(start, range.location);
        end = MAX(end, range.location + range.length - 1);
    }
    [result addObject:[NSValue valueWithRange:NSMakeRange(start, end - start + 1)]];
    
    for (;i < sortedIntervals.count; i++) {
        [result addObject:sortedIntervals[i]];
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSRange a = NSMakeRange(1, 3);
        NSRange b = NSMakeRange(6, 4);
        NSRange c = NSMakeRange(2, 4);
        
        [Range insertInterval:c sortedIntervals:@[[NSValue valueWithRange:a], [NSValue valueWithRange:b]]];
    }
}

