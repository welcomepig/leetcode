#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (AddBinary)

+ (NSString*)fromHex:(NSUInteger)hex;
+ (NSUInteger)toHex:(char)data;

- (NSString*)addHex:(NSString*)data;
- (NSString*)addBinary:(NSString*)data;

@end

@implementation NSString (AddBinary)

+ (NSString*)fromHex:(NSUInteger)hex
{
    if (hex < 10) {
        return [NSString stringWithFormat:@"%lu", hex];
    }
    
    switch (hex) {
    case 10:
        return @"A";
    case 11:
        return @"B";
    case 12:
        return @"C";
    case 13:
        return @"D";
    case 14:
        return @"E";
    case 15:
        return @"F";
    }
    
    return @"";
}

+ (NSUInteger)toHex:(char)data
{
    NSInteger num = data - 'A';
    if (num >= 0 && num <= 5) {
        return 10 + num;
    }
    
    num = data - '0';
    if (num >= 0 && num <= 9) {
        return num;
    }
    
    return 0;
}
    
- (NSString*)addHex:(NSString*)data
{
    NSMutableString *result = [NSMutableString string];
    NSInteger m = self.length - 1;
    NSInteger n = data.length - 1;

    NSUInteger num = 0;
    NSUInteger carry = 0;
    
    while (m >= 0 || n >= 0 || carry >= 1) {
        NSUInteger a = (m >= 0) ? [NSString toHex:[self characterAtIndex:m]] : 0;
        NSUInteger b = (n >= 0) ? [NSString toHex:[data characterAtIndex:n]] : 0;
        
        num = (a + b + carry) % 16;
        carry = (a + b + carry >= 16) ? 1 : 0;
        
        result = [NSString stringWithFormat:@"%@%@", [NSString fromHex:num], result];
        
        m--;
        n--;
    }
    
    
    return [NSString stringWithString:result];
}
    
- (NSString*)addBinary:(NSString*)data
{
    NSMutableString *result = [NSMutableString string];
    NSInteger m = self.length - 1;
    NSInteger n = data.length - 1;

    NSUInteger num = 0;
    NSUInteger carry = 0;
    
    while (m >= 0 || n >= 0 || carry == 1) {
        NSUInteger a = (m >= 0) ? [self characterAtIndex:m] - '0' : 0;
        NSUInteger b = (n >= 0) ? [data characterAtIndex:n] - '0' : 0;
        
        num = (a + b + carry) % 2;
        carry = (a + b + carry >= 2) ? 1 : 0;
        
        result = [NSString stringWithFormat:@"%lu%@", num, result];
        
        m--;
        n--;
    }
    
    
    return [NSString stringWithString:result];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *str = @"10001";
        NSString *result = [str addBinary:@"1011"];
        
        NSLog(@"%@", result);
        
        
        NSString *str1 = @"1A5B1";
        NSString *result2 = [str1 addHex:@"C01"];
        
        NSLog(@"%@", result2);
    }
}

