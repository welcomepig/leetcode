#import <Foundation/Foundation.h>

@interface NSNumber (CountPrimes)

- (NSUInteger)countPrimes;

@end

@implementation NSNumber (CountPrimes)

- (NSUInteger)countPrimes {
    NSUInteger count = 0;
    NSInteger num = [self integerValue];
    
    BOOL *isPrime = (BOOL*)malloc(num * sizeof(BOOL));
    for (NSUInteger i = 0;i < num; i++) {
        isPrime[i] = YES;
    }
    
    for (NSUInteger i = 2;i < num; i++) {
        if (isPrime[i]) {
            count++;
            
            for (NSUInteger j = 2;i * j < num; j++) {
                isPrime[i * j] = NO;
            }
        }
    }
    
    return count;
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%ld", [@(10) countPrimes]);
}

