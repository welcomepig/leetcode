#import <Foundation/Foundation.h>

NSString *integerToRoman(NSInteger num) {
    NSString *symbols[] = { @"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I" };
    NSInteger values[] = { 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *str = [NSMutableString string];
    NSInteger i, j, k;
    
    i = 0;
    while (num > 0) {
        k = num / values[i];
        for (j = 0;j < k; j++) {
            [str appendString:symbols[i]];
            num -= values[i];
        }
    
        i++;
    }
    
    return [str copy];
}

int main(int argc, char * argv[]) {
    NSLog(@"%@", integerToRoman(22));       // XXII
    NSLog(@"%@", integerToRoman(39));       // XXXIX
    NSLog(@"%@", integerToRoman(246));      // CCXLVI
    NSLog(@"%@", integerToRoman(1066));     // MLXVI
    
    return 0;
}

