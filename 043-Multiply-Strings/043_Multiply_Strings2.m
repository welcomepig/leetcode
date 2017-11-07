#import <Foundation/Foundation.h>

NSString *multiplyString(NSString *num1, NSString *num2)
{
    NSInteger i, j, d1, d2, n1, n2, sum;
    NSInteger *digits = (NSInteger *)malloc(sizeof(NSInteger) * (num1.length + num2.length));
    for (i = 0;i < num1.length + num2.length; i++) {
        digits[i] = 0;
    }
    
    for (i = num1.length - 1;i >= 0; i--) {
        n1 = [num1 characterAtIndex:i] - '0';
        d1 = num1.length - 1 - i;
        for (j = num2.length - 1;j >= 0; j--) {
            n2 = [num2 characterAtIndex:j] - '0';
            d2 = num2.length - 1 - j;
            
            sum = digits[d1 + d2] + (n1 * n2);
            digits[d1 + d2] = sum % 10;
            digits[d1 + d2 + 1] += sum / 10;
        }
    }
    
    NSMutableString *n = [NSMutableString string];
    i = num1.length + num2.length - 1;
    while (digits[i] == 0 && i >= 0) i--;
    for (;i >= 0; i--) {
        [n appendFormat:@"%ld", digits[i]];
    }
    
    if (digits) {
        free(digits);
    }
    
    return [n copy];
}

int main(int argc, char * argv[]) {
    NSLog(@"%@", multiplyString(@"123", @"77"));
    return 0;
}

