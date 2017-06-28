#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (Palindrome)

+(BOOL)isAlphaNum:(char)character;
-(BOOL)isPalindrome;

@end

@implementation NSString (Palindrome)

+(BOOL)isAlphaNum:(char)character
{
    if (character - '0' >= 0 && character - '0' <= 9) {
        return YES;
    }
    if (character - 'a' >= 0 && character - 'z' <= 0) {
        return YES;
    }
    if (character - 'A' >= 0 && character - 'Z' <= 0) {
        return YES;
    }
    
    return NO;
}

+(char)toLower:(char)character
{
    if (character - 'a' >= 0 && character - 'z' <= 0) {
        return character;
    }
    
    return character - 'A' + 'a';
}

-(BOOL)isPalindrome
{
    NSInteger i, j;
    
    i = 0;
    j = self.length - 1;
    
    while (i < j) {
        if (![NSString isAlphaNum:[self characterAtIndex:i]]) {
            i++;
            continue;
        }
        if (![NSString isAlphaNum:[self characterAtIndex:j]]) {
            j--;
            continue;
        }
        if ([NSString toLower:[self characterAtIndex:i]] != [NSString toLower:[self characterAtIndex:j]]) {
            return NO;
        }
        i++;
        j--;
    }
    
    return YES;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *data1 = @"A man, a plan, a canal: Panama";
        NSString *data2 = @"race a car";
        
        NSLog(@"%d", [data1 isPalindrome]);
        NSLog(@"%d", [data2 isPalindrome]);
    }
}

