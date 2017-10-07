#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (OneEditDistance)

+(BOOL)isOneEditDistance:(NSString*)strA strB:(NSString*)strB;
-(BOOL)isOneEditDistance:(NSString*)str;

@end

@implementation NSString (OneEditDistance)

+(BOOL)isOneEditDistance:(NSString*)strA strB:(NSString*)strB
{
    for (int i = 0;i < MIN(strA.length, strB.length); i++) {
        if ([strA characterAtIndex:i] != [strB characterAtIndex:i]) {
            if (strA.length == strB.length) {
                return [[strA substringFromIndex:(i+1)] isEqualToString:[strB substringFromIndex:(i+1)]];
            } else if (strA.length > strB.length) {
                return [[strA substringFromIndex:(i+1)] isEqualToString:strB];
            } else {
                return [strA isEqualToString:[strB substringFromIndex:(i+1)]];
            }
        }
    }
    
    return (abs(strA.length - strB.length) == 1);
}

-(BOOL)isOneEditDistance:(NSString*)str
{
    return [NSString isOneEditDistance:self strB:str];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *a = @"1234";
        NSLog(@"%d", [a isOneEditDistance:@"123"]);
    }
}

