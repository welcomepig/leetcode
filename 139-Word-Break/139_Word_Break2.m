#import <Foundation/Foundation.h>

@interface NSString (WordBreak)

- (BOOL)isWordBreak:(NSArray*)dicts;

@end

@implementation NSString (WordBreak)

- (BOOL)isWordBreak:(NSArray*)dicts
{
    BOOL dp[self.length + 1];
    BOOL canBreak = NO;
    
    for (int i = 0;i <= self.length; i++) {
        dp[0] = NO;
    }
    dp[0] = YES;
    
    for (int i = 0;i < self.length; i++) {
        if (dp[i]) {
            for (NSString *dict in dicts) {
                if (i + dict.length > self.length) {
                    continue;
                }
                canBreak = YES;
                for (int j = 0;j < dict.length; j++) {
                    if ([self characterAtIndex:(i+j)] != [dict characterAtIndex:j]) {
                        canBreak = NO;
                        break;
                    }
                }
                if (canBreak) {
                    dp[i+dict.length] = YES;
                }
            }
        }
    }
    
    return dp[self.length];
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%d", [@"leetcode" isWordBreak:@[@"leet", @"code"]]);
}
