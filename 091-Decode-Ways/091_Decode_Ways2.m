#import <Foundation/Foundation.h>

@interface NSString (DecodeWays)

- (NSUInteger)docodeWays;

@end

@implementation NSString (DecodeWays)

- (NSUInteger)docodeWays
{
    NSUInteger dp[self.length + 1];
    NSInteger n1, n2;
    
    dp[0] = 1;
    dp[1] = [self characterAtIndex:0] == '0' ? 0 : 1;
    
    for (int i = 2;i <= self.length; i++) {
        dp[i] = 0;
    }
    for (int i = 2;i <= self.length; i++) {
        n1 = [self characterAtIndex:i-1] - '0';
        if (n1 >= 1 && n1 <= 9) {
            dp[i] += dp[i-1];
        }
        n2 = [self characterAtIndex:i-2] - '0';
        if (n2 == 1 || (n2 == 2 && n1 <= 6)) {
            dp[i] += dp[i-2];
        }
    }
    
    return dp[self.length];
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%lu", [@"12" docodeWays]);
}
