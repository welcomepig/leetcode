#import <Foundation/Foundation.h>

NSString *countAndSay(NSUInteger n)
{
    if (n == 0) return @"";
    
    NSMutableString *s = [@"1" mutableCopy];
    NSMutableString *s2;
    NSInteger i, j, cnt;
    char c;
    
    for (j = 1; j < n; j++) {
        i = 1; cnt = 1;
        c = [s characterAtIndex:0];
        s2 = [NSMutableString string];
        while (i < s.length) {
            if (c == [s characterAtIndex:i]) {
                cnt++; i++;
                continue;
            }
            
            [s2 appendFormat:@"%ld%c", cnt, c];
            c = [s characterAtIndex:i];
            i++; cnt = 1;
        }
        [s2 appendFormat:@"%ld%c", cnt, c];
        s = s2;
    }
    
    return [s copy];
}

int main(int argc, char * argv[]) {
    NSLog(@"%@", countAndSay(4));
    NSLog(@"%@", countAndSay(7));
    return 0;
}

