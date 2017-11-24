#import <Foundation/Foundation.h>

NSString *numberToWords(NSUInteger num)
{
    NSMutableString *result = [NSMutableString string];
    NSArray *values = @[@(1000 * 1000 * 1000), @(1000 * 1000), @(1000), @(100)];
    NSArray *units = @[@"Billion", @"Million", @"Thousand", @"Hundred"];
    
    for (NSInteger i = 0;i < values.count; i++) {
        if (num >= [values[i] integerValue]) {
            [result appendFormat:@"%@ %@", numberToWords(num / [values[i] integerValue]), units[i]];
            num = num % [values[i] integerValue];
        }
    }
 
    NSArray *svalues = @[@(90), @(80), @(70), @(60), @(50), @(40), @(30), @(20), 
                         @(19), @(18), @(17), @(16), @(15), @(14), @(13), @(12), @(11), @(10),
                         @(9), @(8), @(7), @(6), @(5), @(4), @(3), @(2), @(1)];
    NSArray *sunits = @[@"Ninety", @"Eighty", @"Seventy", @"Sixty", @"Fifty", @"Forty", @"Thirty", @"Twenty", 
                        @"Nineteen", @"Eighteen", @"Seventeen", @"Sixteen", @"Fifteen", @"Fourteen", @"Thirteen", @"Twelve", @"Eleven", @"Ten", 
                        @"Nine", @"Eight", @"Seven", @"Six", @"Five", @"Four", @"Three", @"Two", @"One"];

    for (NSInteger i = 0;i < svalues.count; i++) {
        if (num >= [svalues[i] integerValue]) {
            [result appendFormat:@" %@", sunits[i]];
            num = num - [svalues[i] integerValue];
        }
    }
    
    return [result stringByTrimmingCharactersInSet:[NSMutableCharacterSet whitespaceCharacterSet]];
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"\"%@\"", numberToWords(123));
        NSLog(@"\"%@\"", numberToWords(12345));
        NSLog(@"\"%@\"", numberToWords(1234567));
    }
}

