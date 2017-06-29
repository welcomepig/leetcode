#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (MinimumWindowSubstring)

-(NSString*)minimumWindowSubstring:(NSString*)word;

@end

@implementation NSString (MinimumWindowSubstring)

-(NSString*)minimumWindowSubstring:(NSString*)word
{
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    NSInteger i, left, right, count, minl, min = self.length + 1;
    char c;
    
    for (i = 0;i < word.length;i++) {
        c = [word characterAtIndex:i];
        if (!map[@(c)]) {
            [map setObject:@(0) forKey:@(c)];
        } else {
            map[@(c)] = @([map[@(c)] integerValue] + 1);
        }
    }
    
    minl = left = count = 0;
    for (right = 0;right < self.length; right++) {
        c = [self characterAtIndex:right];
        if (map[@(c)] && [map[@(c)] integerValue] > 0) {
            map[@(c)] = @([map[@(c)] integerValue] - 1);
            count++;
        }
        
        while (count == word.length) {
            if (right - left + 1 < min) {
                min = right - left + 1;
                minl = left;
            }
            c = [self characterAtIndex:left];
            if (map[@(c)] && [map[@(c)] integerValue] == 0) {
                map[@(c)] = @([map[@(c)] integerValue] + 1);
                count--;
            }
            left++;
        }
    }
    
    return (min == self.length + 1) ? @"" : [self substringWithRange:NSMakeRange(minl, min)];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%@", [@"ADOBECODEBANC" minimumWindowSubstring:@"ABC"]);
    }
}
