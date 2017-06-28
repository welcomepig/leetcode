#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <stdio.h>

@interface NSString (ReverseWord)

-(NSString*)reverseWord;

@end

@implementation NSString (ReverseWord)

-(NSString*)reverseWord
{
    NSMutableString *result = [NSMutableString string];
    NSArray *words = [self componentsSeparatedByString:@" "];
    BOOL isFirst = YES;
    
    for (NSInteger i = words.count - 1;i >= 0; i--) {
        if ([words[i] isEqual:@""]) {
            // skip empty string
            continue;
        }
        
        if (isFirst) {
            [result appendFormat:@"%@", words[i]];
            isFirst = NO;
        } else {
            [result appendFormat:@" %@", words[i]];
        }
    }
    
    return [result copy];
}

@end

@interface NSMutableString (ReverseWord)

-(void)reverseWordInplace;

@end

@implementation NSMutableString (ReverseWord)

-(void)reverseWordFrom:(NSInteger)i to:(NSInteger)j
{
    NSString *c;
    
    while (i < j) {
        c = [self substringWithRange:NSMakeRange(j, 1)];
        [self replaceCharactersInRange:NSMakeRange(j, 1)
                            withString:[self substringWithRange:NSMakeRange(i, 1)]];
        [self replaceCharactersInRange:NSMakeRange(i, 1) withString:c];
        i++; j--;
    }
}

-(void)reverseWordInplace
{
    NSInteger i, j;
    
    [self reverseWordFrom:0 to:(self.length - 1)];
    
    i = 0, j = 0;
    while (i < self.length && j < self.length) {
        // i: point to non-space
        while (i < self.length && [[self substringWithRange:NSMakeRange(i, 1)] isEqual:@" "]) {
            i++;
        }
        j = i + 1;
        // j: point to first space after i
        while (j < self.length && ![[self substringWithRange:NSMakeRange(j, 1)] isEqual:@" "]) {
            j++;
        }
        
        [self reverseWordFrom:i to:(j - 1)];
        i = j + 1;
    }
    
    if (i < self.length) {
        [self reverseWordFrom:i to:(self.length - 1)];
    }
    
    /* clean white space */
    i = 0, j = 0;
    while (i < self.length) {
        // i: point to non-space
        while (i < self.length && [[self substringWithRange:NSMakeRange(i, 1)] isEqual:@" "]) {
            i++;
        }
        
        // move non-zero element to leading
        while (i < self.length && ![[self substringWithRange:NSMakeRange(i, 1)] isEqual:@" "]) {
            [self replaceCharactersInRange:NSMakeRange(j, 1)
                                withString:[self substringWithRange:NSMakeRange(i, 1)]];
            j++; i++;
        }

        // handle white-space in the middle
        // 1. skip white
        while (i < self.length && [[self substringWithRange:NSMakeRange(i, 1)] isEqual:@" "]) {
            i++;
        }
        
        // 2. leave one white space
        if (j < self.length) {
            [self replaceCharactersInRange:NSMakeRange(j, 1) withString:@" "];
            j++;
        }
    }
    
    [self replaceCharactersInRange:NSMakeRange(j - 1, self.length - j) withString:@""];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *data = @"  the sky  is blue ";
        NSLog(@"[%@]", [data reverseWord]);
        NSMutableString *mdata = [data mutableCopy];
        [mdata reverseWordInplace];
        NSLog(@"[%@]", mdata);
    }
}
