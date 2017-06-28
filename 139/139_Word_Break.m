#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (WordBreak)

-(BOOL)isWordBreak:(NSArray*)dicts;

@end

@implementation NSString (WordBreak)

-(BOOL)isWordBreak:(NSArray*)dicts
{
    BOOL dp[self.length+1];
    NSInteger i, j;
    
    for (i = 0;i <= self.length;i++) {
        dp[i] = NO;
    }
    
    dp[0] = YES;
    
    for (i = 1;i <= self.length;i++) {
        for (j = 0;j < i;j++) {
            if (!dp[j]) {
                continue;
            }
            
            if ([dicts containsObject:[self substringWithRange:NSMakeRange(j, i - j)]]) {
                dp[i] = YES;
                break;
            }
        }
    }
    
    return (dp[self.length] == YES);
}


@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%d", [@"leetcode" isWordBreak:@[@"leet", @"code"]]);
    }
}

