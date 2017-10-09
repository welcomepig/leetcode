#import <Foundation/Foundation.h>

@interface NSArray (BuyStock)

- (NSUInteger)maxProfit;

@end

@implementation NSArray (BuyStock)

- (NSUInteger)maxProfit
{
    if (self.count == 0) return 0;
    
    NSInteger maxProfit = 0;
    NSInteger lowestPrice = [self[0] integerValue];
    
    for (NSInteger i = 1;i < self.count; i++) {
        maxProfit = MAX(maxProfit, [self[i] integerValue] - lowestPrice);
        lowestPrice = MIN(lowestPrice, [self[i] integerValue]);
    }
    
    return maxProfit;
}


@end

int main(int argc, char * argv[]) {
    NSArray *data = @[@(7), @(1), @(5), @(3), @(6), @(4)];
    NSLog(@"%lu", [data maxProfit]);
    
    return 0;
}
