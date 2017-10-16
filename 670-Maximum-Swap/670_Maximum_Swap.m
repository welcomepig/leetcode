#import <Foundation/Foundation.h>

NSUInteger maximumSwap(NSUInteger number) {
    NSUInteger *digits = (NSUInteger *)malloc(sizeof(NSUInteger) * 9);
    NSInteger i, j, k, max, maxidx, count;
    NSUInteger num = number;
    
    i = -1;
    while (num > 0) {
        digits[++i] = num % 10;
        num = num / 10;
    }
    
    count = i;
    for (;i > 0; i--) {
        max = digits[i] + 1;
        maxidx = i;
        for (j = i - 1;j >= 0; j--) {               
            if (digits[j] >= max) {
                max = digits[j];
                maxidx = j;
            }
        }
        if (maxidx != i) {
            NSUInteger tmp = digits[i];
            digits[i] = digits[maxidx];
            digits[maxidx] = tmp;
            
            tmp = 0;
            for (k = count;k >= 0; k--) {
                tmp = tmp * 10 + digits[k];
            }
            return tmp;
        }
    }
    
    return number;
}

NSUInteger maximumSwapDP(NSUInteger number) {
    NSInteger i, maxidx;
    NSMutableString *num = [NSMutableString stringWithFormat:@"%lu", number];
    NSUInteger *dp = (NSUInteger *)malloc(sizeof(NSUInteger) * num.length);
    
    maxidx = num.length - 1;
    for (i = num.length - 1;i >= 0; i--) {
        if (([num characterAtIndex:i] - '0') > ([num characterAtIndex:maxidx] - '0')) {
            maxidx = i;
        }
        dp[i] = maxidx;
    }

    for (i = 0;i < num.length; i++) {
        if ([num characterAtIndex:i] != [num characterAtIndex:dp[i]]) {
            char tmp = [num characterAtIndex:i];
            [num replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c", [num characterAtIndex:dp[i]]]];
            [num replaceCharactersInRange:NSMakeRange(dp[i], 1) withString:[NSString stringWithFormat:@"%c", tmp]];
            break;
        }
    }
    
    return [num integerValue];
}

int main(int argc, char * argv[]) {
    NSLog(@"%lu", maximumSwap(1993));
    NSLog(@"%lu", maximumSwapDP(1993));
    return 0;
}

