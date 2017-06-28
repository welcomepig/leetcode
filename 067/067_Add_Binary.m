#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (AddBinary)

- (NSString*)addBinary:(NSString*)data;

@end

@implementation NSString (AddBinary)

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
    }
}

