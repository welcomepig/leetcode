#import <Foundation/Foundation.h>

@interface NSMutableString (ReverseWord)

- (void)reverseWord;

@end

@implementation NSMutableString (ReverseWord)

- (void)trimAndReduceWhiteSpace
{
    if (self.length == 0) return;
    
    NSInteger i = 0;
    NSInteger j = 0;
    
    // 1. ignore leading white spaces
    while ([self characterAtIndex:i] == ' ' && i < self.length) {
        i++;
    }
    
    // 2. 
    while (i < self.length) {
        [self replaceCharactersInRange:NSMakeRange(j, 1)
                            withString:[self substringWithRange:NSMakeRange(i, 1)]];
        j++; i++;
        
        if ([self characterAtIndex:i-1] == ' ') {
            while (i < self.length && [self characterAtIndex:i] == ' ') {
                i++;
            }
        }
    }
    
    // 3. ignore backward white space
    if (j > 0 && [self characterAtIndex:j-1] == ' ') {
        j--;
    }
    
    [self replaceCharactersInRange:NSMakeRange(j, self.length - j) withString:@""];
}

- (void)reverseWord
{
    if (self.length < 1) return;
    
    [self trimAndReduceWhiteSpace];
    
    NSInteger i = 0;
    NSInteger j = self.length - 1;
    NSString *tmp;
    
    while (i < j) {
        tmp = [self substringWithRange:NSMakeRange(i, 1)];
        [self replaceCharactersInRange:NSMakeRange(i, 1)
                            withString:[self substringWithRange:NSMakeRange(j, 1)]];
        [self replaceCharactersInRange:NSMakeRange(j, 1)
                            withString:tmp];
        i++; j--;
    }
    
    NSInteger k = 0;
    i = 0;
    for (k = 0;k <= self.length; k++) {
        if (k == self.length || [self characterAtIndex:k] == ' ') {
            j = k - 1;
            while (i < j) {
                tmp = [self substringWithRange:NSMakeRange(i, 1)];
                [self replaceCharactersInRange:NSMakeRange(i, 1)
                                    withString:[self substringWithRange:NSMakeRange(j, 1)]];
                [self replaceCharactersInRange:NSMakeRange(j, 1)
                                    withString:tmp];
                i++; j--;
            }
            i = k + 1;
        }
    }
}

@end

@interface NSString (ReverseWord)

- (NSString*)reversedWord;

@end

@implementation NSString (ReverseWord)

- (NSString*)reversedWord
{
    NSMutableString *result = [NSMutableString string];
    NSArray *words = [self componentsSeparatedByString:@" "];
    
    for (NSInteger i = words.count - 1;i >= 0; i--) {
        if ([words[i] isEqual:@""]) {
            continue;
        }
        
        [result isEqual:@""] ? 
        [result appendFormat:@"%@", words[i]] :
        [result appendFormat:@" %@", words[i]];
    }
    
    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    NSString *data = @"  the sky  is blue ";
    NSLog(@"[%@]", [data reversedWord]);
    
    NSMutableString *mdata = [data mutableCopy];
    [mdata reverseWord];
    NSLog(@"[%@]", mdata);
}
