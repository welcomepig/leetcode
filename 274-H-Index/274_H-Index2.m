#import <Foundation/Foundation.h>

/*NSUInteger hIndex(NSArray<NSNumber*> *citations) {
    if (citations.count == 0) return 0;
    
    NSArray *sortedCitation = [citations sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2){
        if (obj1 < obj2) {
            return NSOrderedDescending;
        } else if (obj1 > obj2) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    NSInteger lo = 0;
    NSInteger hi = citations.count - 1;
    NSInteger h, m;
    
    while (lo <= hi) {
        m = lo + (hi - lo)/2;
        
        if ([citations[m] integerValue] == m + 1) return (m + 1);
        if ([citations[m] integerValue] > m + 1) {
            lo = m + 1;
        } else {
            hi = m - 1;
        }
    }
    
    return (m + 1);
}*/

NSUInteger hIndexIteration(NSArray<NSNumber*> *citations) {
    if (citations.count == 0) return 0;
    
    NSArray *sortedCitation = [citations sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2){
        if (obj1 < obj2) {
            return NSOrderedDescending;
        } else if (obj1 > obj2) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    for (NSInteger i = 0;i < sortedCitation.count; i++) {
        if ([sortedCitation[i] integerValue] < i + 1) return i;
    }
    
    return citations.count;
}

NSUInteger hIndexBucket(NSArray<NSNumber*> *citations) {
    if (citations.count == 0) return 0;
    
    NSInteger i, t, length = citations.count;
    NSInteger bucket[length + 1];
    
    for (i = 0;i <= length; i++) {
        bucket[i] = 0;
    }
    
    for (i = 0;i < length; i++) {
        if ([citations[i] integerValue] > length) {
            bucket[length]++;
        } else {
            bucket[[citations[i] integerValue]]++;
        }
    }
    
    t = 0;
    for (i = length; i >= 0; i--) {
        t += bucket[i];
        if (t >= i) {
            return i;
        }
    }
    
    return 0;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%lu", hIndexIteration(@[@(3), @(0), @(6), @(1), @(5)]));
        NSLog(@"%lu", hIndexBucket(@[@(3), @(0), @(6), @(1), @(5)]));
    }
}

