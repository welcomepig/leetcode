// O(n) time where n is the number of elements in array
// constant space
#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (BuyAndSellStock)

- (NSUInteger)findMaxProfit;

@end

@implementation NSArray (BuyAndSellStock)

// Assume all object in array is NSNumber
- (NSUInteger)findMaxProfit
{
    if (self.count == 0) {
        return 0;
    }
    
    NSUInteger i;
    NSInteger buy, maxprofit, profit, price;
    
    buy = [(NSNumber*)self[0] intValue];
    maxprofit = 0;
    
    for (i = 1;i < self.count; i++) {
        if ([self[i] isKindOfClass:[NSNumber class]]) {
            price = [(NSNumber*)self[i] intValue];
            profit = price - buy;
            
            if (price < buy) {
                buy = price;
            } else if (profit > maxprofit) {
                maxprofit = profit;
            }
        }
    }
    
    return maxprofit;
}

- (NSUInteger)findMaxProfitFastEnum
{
    if (self.count == 0) {
        return 0;
    }
    
    BOOL isFirstElement = true;
    NSInteger curval, minval, diff, maxdiff;
    
    for (NSObject *price in self) {
        if ([price isKindOfClass:[NSNumber class]]) {
            curval = [(NSNumber*)price intValue];
            
            if (isFirstElement) {
                minval = curval;
                maxdiff = 0;
                isFirstElement = false;
                continue;
            }
            
            diff = curval - minval;
            if (diff < 0) {
                minval = curval;
            } else if (diff > maxdiff) {
                maxdiff = diff;
            }
        }
    }
    
    return maxdiff;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = [NSArray arrayWithObjects:@(7), @(1), @(5), @(3), @(6), @(4), nil];
        
        NSLog(@"%lu", [data findMaxProfit]);
    }
}
