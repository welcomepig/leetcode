#import <Foundation/Foundation.h>

NSUInteger hammingDistance(NSInteger a, NSInteger b) {
    NSInteger d = a ^ b;
    NSUInteger bits = 0;
    
    while (d != 0) {
        bits += d & 1;
        d = d >> 1;
    }
    
    return bits;
}


int main(int argc, char * argv[]) {
    return 0;
}

