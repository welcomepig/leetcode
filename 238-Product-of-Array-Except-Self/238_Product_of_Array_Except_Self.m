#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (Product)

-(NSArray*)products;

@end

@implementation NSArray (Product)

-(NSArray*)products
{
    NSMutableArray *products = [NSMutableArray array];
    
    for (int i = 0;i < self.count; i++) {
        [products addObject:@(1)];
    }
    
    for (int i = 0;i < self.count; i++) {
        for (int j = 0;j < self.count; j++) {
            if (i == j) continue;
            products[j] = @([products[j] integerValue] * [self[i] integerValue]);
        }
    }
    
    return [products copy];
}

-(NSArray*)products2
{
    NSMutableArray *products = [NSMutableArray array];
    NSInteger i, sum;
    
    for (i = 0;i < self.count; i++) {
        [products addObject:@(1)];
    }
    
    for (i = 1;i < self.count; i++) {
        products[i] = @([products[i - 1] integerValue] * [self[i - 1] integerValue]);
    }
    
    sum = 1;
    for (i = self.count - 1;i >= 0; i--) {
        products[i] = @([products[i] integerValue] * sum);
        sum = sum * [self[i] integerValue];
    }
    
    return [products copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(1), @(2), @(3), @(4)];
        NSLog(@"%@", [data products2]);
    }
}

