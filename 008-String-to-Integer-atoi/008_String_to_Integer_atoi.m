#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (Atoi)

+ (NSInteger)toInt:(char)data;
- (NSInteger)atoi;

@end
    
@implementation NSString (Atoi)    

+ (NSInteger)toInt:(char)data
{
    return (data - '0');
}

- (NSInteger)atoi
{
    if (self.length == 0) {
        return 0;
    }
    
    bool isNegative = false;
    NSInteger result = 0;
    NSUInteger i = 0;
    
    // ignore leading white space
    while ([self characterAtIndex:i] == ' ') {
        i++;
        
        if (i == self.length) {
            return 0;
        }
    }
    
    // positive and negative sign
    if ([self characterAtIndex:i] == '-') {
        isNegative = true;
        i++;
    } else if ([self characterAtIndex:i] == '+') {
        i++;
    }
    
    // char to int, return immediately if illegal character
    for (;i < self.length; i++) {
        NSInteger value = [NSString toInt:[self characterAtIndex:i]];
        if (value < 0 || value > 9) {
            break;
        }
        result = 10 * result + value;
    }
    
    result = (isNegative) ? -result : result; 
    
    return result;
}
    
@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *str1 = @"321";
        NSLog(@"%ld", [str1 atoi]);
        
        NSString *str2 = @"  -321";
        NSLog(@"%ld", [str2 atoi]);
        
        NSString *str3 = @"  -3 21";
        NSLog(@"%ld", [str3 atoi]);
    }
}
