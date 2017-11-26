#import <Foundation/Foundation.h>

NSUInteger hIndex(NSArray *citations) {
    NSInteger lo = 0;
    NSInteger hi = citations.count - 1;
    NSInteger mid = lo + (hi - lo)/2;
    
    while (lo <= hi) {
        NSInteger h = citations.count - mid;
        if ([citations[mid] integerValue] == h) return h;
        if ([citations[mid] integerValue] < h) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
        mid = lo + (hi - lo)/2;
    }
    
    return (citations.count - lo);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

