#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (strStr)

-(BOOL)isMatch:(NSString*)pattern;

@end

@implementation NSString (strStr)

-(BOOL)isMatchFrom:(NSInteger)i pattern:(NSString*)pattern j:(NSInteger)j
{
    if (j == pattern.length) {
        return (i == self.length);
    }

    char wc = (i < self.length) ? [self characterAtIndex:i] : ' ';
    char pc = [pattern characterAtIndex:j];
    char npc = (j + 1 < pattern.length) ? [pattern characterAtIndex:(j+1)] : ' ';
    
    if (npc != '*') {
        return (i < self.length) && (pc == '.' || wc == pc) && [self isMatchFrom:(i+1) pattern:pattern j:(j+1)];
    }
    
    /* wildcard case */
    return [self isMatchFrom:i pattern:pattern j:(j+2)] ||
            ((i < self.length) && (pc == '.' || wc == pc) && [self isMatchFrom:(i+1) pattern:pattern j:j]);
}

-(BOOL)isMatch:(NSString*)pattern
{
    return [self isMatchFrom:0 pattern:pattern j:0];
}

-(BOOL)isMatchDP:(NSString*)pattern
{
    BOOL dp[self.length+1][pattern.length+1];
    NSInteger i, j;
    
    dp[0][0] = YES;
    
    for (j = 0; j < pattern.length; j++) {
        char pc = [pattern characterAtIndex:j];
        if (pc == '*' && dp[0][j-1]) {
            dp[0][j+1] = YES;
        }
    }
    
    for (i = 0;i < self.length; i++) {
        char wc = [self characterAtIndex:i];
        for (j = 0;j < pattern.length; j++) {
            char pc = [pattern characterAtIndex:j];
            
            if (pc == '.' || wc == pc) {
                dp[i+1][j+1] = dp[i][j];
            }
            if (pc == '*') {
                char ppc = [pattern characterAtIndex:(j-1)];
                if (ppc == '.' || wc == ppc) {
                    dp[i+1][j+1] = dp[i+1][j-1] || dp[i+1][j] || dp[i][j+1];
                } else {
                    dp[i+1][j+1] = dp[i+1][j-1];
                }
            }
        }
    }
    
    return dp[self.length][pattern.length];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%d", [@"aa" isMatchDP:@"a*"]);
    }
}

