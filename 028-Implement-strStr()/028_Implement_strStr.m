@interface NSString (strStr)

- (NSInteger)strStr:(NSString*)needle;

@end

@implementation NSString (strStr)

- (NSInteger)strStr:(NSString*)needle
{
    NSInteger i, j, result = -1;

    for (i = 0;i < self.length - needle.length + 1; i++) {
        for (j = 0;j < needle.length; j++) {
            if ([self characterAtIndex:i+j] != [needle characterAtIndex:j]) {
                break;
            }
        }
        if (j == needle.length) {
            result = i;
            break;
        }
    }

    return result;
}

@end

int main (int argc, const char * argv[])
{
    NSString *str1 = @"abcdabcdefg";
    NSLog(@"%ld", [str1 strStr:@"bcd"]);

    NSString *str2 = @"source";
    NSLog(@"%ld", [str2 strStr:@"target"]);
}
