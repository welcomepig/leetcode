#import <Foundation/Foundation.h>

@interface NSString (strStr)

- (NSInteger)strStr:(NSString *)needle;

@end

@implementation NSString (strStr)

- (NSInteger)strStr:(NSString *)needle
{
    NSInteger i, j;
    
    for (i = 0;i <= self.length - needle.length; i++) {
        for (j = 0;j < needle.length;j++) {
            if ([self characterAtIndex:(i+j)] != [needle characterAtIndex:j]) {
                break;
            }
        }
        if (j == needle.length) {
            return i;
        }
    }
    return -1;
}

@end

int main(int argc, char * argv[]) {
    NSString *str1 = @"abcdabcdefg";
    NSLog(@"%ld", [str1 strStr:@"bcd"]);
    
    NSString *str2 = @"source";
    NSLog(@"%ld", [str2 strStr:@"target"]);
}
