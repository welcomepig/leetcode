#import <Foundation/Foundation.h>

@interface NSString (Palindrome)

- (BOOL)isPalindrome;

@end

@implementation NSString (Palindrome)

- (BOOL)isPalindrome:(NSInteger)i j:(NSInteger)j
{
    while (i < j) {
        if ([self characterAtIndex:i] != [self characterAtIndex:j]) {
            return NO;
        }
        
        i++; j--;
    }
    
    return YES;
}

- (BOOL)isPalindrome
{
    if (self.length == 0) return YES;
    
    NSInteger i = 0;
    NSInteger j = self.length - 1;
    
    while (i < j) {
        if ([self characterAtIndex:i] != [self characterAtIndex:j]) {
            if ([self isPalindrome:i j:(j-1)] || [self isPalindrome:(i+1) j:j]) {
                return YES;
            } else {
                return NO;
            }
        }
        
        i++; j--;
    }
    
    return YES;
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%d", [@"ebcbbececabbacecbbcbe" isPalindrome]);
}
