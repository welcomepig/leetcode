#import <Foundation/Foundation.h>

NSUInteger romanToInteger(NSString *roman)
{
    NSDictionary *map = @{
        @('I') : @(1),
        @('V') : @(5),
        @('X') : @(10),
        @('L') : @(50),
        @('C') : @(100),
        @('D') : @(500),
        @('M') : @(1000)
    };
    
    NSUInteger value = 0;
    NSInteger cur, prev = 0;
    
    for (NSInteger i = roman.length - 1;i >= 0; i--) {
        cur = [map[@([roman characterAtIndex:i])] integerValue];
        value = (prev > cur) ? value - cur : value + cur;
        prev = cur;
    }
    
    return value;
}

int main(int argc, char * argv[]) {
    NSLog(@"%lu", romanToInteger(@"XXII"));         // 22
    NSLog(@"%lu", romanToInteger(@"XXXIX"));        // 39
    NSLog(@"%lu", romanToInteger(@"CCXLVI"));       // 246
    NSLog(@"%lu", romanToInteger(@"MLXVI"));        // 1066
    
    return 0;
}

