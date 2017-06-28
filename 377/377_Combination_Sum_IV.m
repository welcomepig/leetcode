#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (Combinations)

-(NSInteger)combinations:(NSInteger)target;

@end

@implementation NSArray (Product)

-(NSInteger)combinations:(NSInteger)target
{
    NSInteger result = 0;
    
    for (NSInteger i = 0;i < self.count; i++) {
        NSInteger value = target - [self[i] integerValue];
        
        if (value == 0) {
            result = result + 1;
        } else if (value > 0) {
            result = result + [self combinations:value];
        }
    }
    
    return result;
}

-(NSInteger)dpCombinations:(NSInteger)target
{
    NSInteger results[target + 1];
    
    for (NSInteger v = 1;v <= target; v++) {
        results[v] = 0;
    }
    
    for (NSInteger v = 1;v <= target; v++) {
        for (NSInteger i = 0;i < self.count; i++) {
            NSInteger value = v - [self[i] integerValue];
            if (value == 0) {
                results[v] = results[v] + 1;
            } else if (value > 0) {
                results[v] = results[v] + results[value];
            }
        }
    }
    
    return results[target];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(1), @(2), @(3)];
        NSLog(@"%ld", [data combinations:4]);
        NSLog(@"%ld", [data dpCombinations:4]);
    }
}

