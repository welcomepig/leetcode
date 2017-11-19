#import <Foundation/Foundation.h>

NSUInteger mySqrt(NSUInteger x) {
    if (x <= 1) return x;
    NSUInteger s, m;
    NSInteger s1;
    
    for (m = 0;m < x; m++) {
        s = m * m;
        s1 = (m + 1)*(m + 1);
        if (s1 < 0 || s == x || (s < x && s1 > x)) {
            return m;
        }
    }
    
    return m;
}

NSUInteger mySqrtBS(NSUInteger x)
{
    if (x <= 1) return x;
    
    NSInteger lo = 1;
    NSInteger hi = x;
    NSInteger m;
    
    while (true) {
        m = lo + (hi - lo)/2;
        
        if (m > x / m) {
            hi = m - 1;
        } else {
            if (m + 1 > x / (m + 1)) return m;
            lo = m + 1;
        }
    }
    
    return lo;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%lu", mySqrtBS(4));
        NSLog(@"%lu", mySqrtBS(2147395599));    // 46339
        NSLog(@"%lu", mySqrtBS(2147483647));    // 46340        
        NSLog(@"%lu", mySqrt(2147395599));      // 46339
        NSLog(@"%lu", mySqrt(2147483647));      // 46340
    }
}

