#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (Anagram)

-(BOOL)isAnagram:(NSString*)word;

@end

@implementation NSString (Anagram)

-(BOOL)isAnagram:(NSString*)word
{
    if (self.length != word.length) {
        return NO;
    }
    
    NSInteger i, j, alphabets[26];
    for (i = 0;i < self.length; i++) {
        j = [self characterAtIndex:i] - 'a';
        alphabets[j]++;
    }
    
    for (i = 0;i < word.length; i++) {
        j = [word characterAtIndex:i] - 'a';
        alphabets[j]--;
        if (alphabets[j] < 0) {
            return NO;
        }
    }
    
    return YES;
}

@end
 
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *data1 = @"cat";
        NSString *data2 = @"act";
        
        NSLog(@"%d", [data1 isAnagram:data2]);
    }
}
