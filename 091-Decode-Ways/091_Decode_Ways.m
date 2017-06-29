#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (DecodeWays)

-(NSInteger)decodeWays;

@end

@implementation NSString (DecodeWays)

-(NSInteger)decodeWays
{
    NSInteger i, v, dp[self.length + 1];
    char c;
    
    dp[self.length] = 1;
    dp[self.length - 1] = ([self characterAtIndex:(self.length - 1)] == '0') ? 0 : 1;
    for (i = self.length - 2;i >= 0; i--) {
        c = [self characterAtIndex:i];
        if (c == '0') {
            dp[i] = 0;
            continue;
        }
        
        v = [[self substringWithRange:NSMakeRange(i, 2)] integerValue];
        dp[i] = (v <= 26) ? dp[i+1] + dp[i+2] : dp[i+1];
    }
    
    return dp[0];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%ld", [@"12" decodeWays]);
    }
}

