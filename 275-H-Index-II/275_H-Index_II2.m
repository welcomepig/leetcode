#import <Foundation/Foundation.h>

NSUInteger hIndexSorted(NSArray<NSNumber*> *citations) {
    if (citations.count == 0) return 0;
    
    NSInteger h = 0;
    for (NSInteger i = citations.count - 1;i >= 0; i--) {
        if ([citations[i] integerValue] <= h) return h;
        h++;
    }
    
    return h;
}

NSUInteger hIndexSorted2(NSArray<NSNumber*> *citations) {
    if (citations.count == 0) return 0;
    
    NSInteger lo = 0;
    NSInteger hi = citations.count - 1;
    NSInteger m, h = 0;
    
    while (lo <= hi) {
        m = lo + (hi - lo)/2;
        h = citations.count - m - 1;
        
        if ([citations[m] integerValue] == h) return h;
        if ([citations[m] integerValue] < h) {
            lo = m + 1;
        } else {
            hi = m - 1;
        }
    }
    
    return (lo >= citations.count) ? 0 : citations.count - lo;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%lu", hIndexSorted2(@[@(0), @(0), @(0), @(0), @(0)]));
        NSLog(@"%lu", hIndexSorted2(@[@(0), @(0), @(0), @(1)]));
        NSLog(@"%lu", hIndexSorted2(@[@(1), @(1), @(1), @(3), @(3)]));
    }
}

