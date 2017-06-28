// O(n * k) time, where n is nth k is the largest length (less than 2^n)
// O(k) space
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (CountAndSay)

+ (NSString*)countAndSay:(NSUInteger)n;

@end

@implementation NSString (CountAndSay)

+ (NSString*)countAndSay:(NSUInteger)n
{
    NSString *s = @"1";
    NSMutableString *result;
    NSInteger i, j, count;
    char cur, prev;
    
    i = 1;
    while (i < n) {
        result = [NSMutableString string];
        prev = [s characterAtIndex:0];
        j = count = 1;
        
        while (j < s.length) {
            cur = [s characterAtIndex:j];
            if (cur == prev) {
                count++;
            } else {
                [result appendFormat:@"%ld%c", count, prev];
                count = 1;
            }
            
            prev = cur;
            j++;
        }
        [result appendFormat:@"%ld%c", count, prev];
        i++;
        
        s = [result copy];
        // faster but less-semantic method
        // NSMutableString *s = [NSMutableString stringWithString:@"1"];
        // s = result;
    }
    
    return result;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%@", [NSString countAndSay:7]);
    }
}
