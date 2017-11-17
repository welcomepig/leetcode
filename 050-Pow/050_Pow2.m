#import <Foundation/Foundation.h>

// double myPow
double myPow(double x, int n) {
    if (x == 0) return 0;
    if (n == 0) return 1;
    if (n == 1) return x;

    double p = myPow(x, n / 2);
    if (n % 2 != 0) return n < 0 ? 1/x * p * p : x * p * p;
    return p * p;
}

// double x
double myPow2(double x, int n) {
    if (x == 0) return 0;
    if (n == 0) return 1;
    if (n == 1) return x;
    
    if (n < 0) {
        if ( n == INT_MIN ) {
            ++n;
            n = -n;
            x = 1/x;
            return x * x * myPow2( x * x, n / 2 );
        }
        n = -n;     // overflow when n is integermin       
        x = 1/x;
    }
    return (n % 2 == 0) ? myPow2(x * x, n / 2) : x * myPow2(x * x, n / 2);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%f", myPow(2.00000, -2147483648));      // 0.000000
        NSLog(@"%f", myPow2(2.00000, -2147483648));     // 0.000000
    }
}

