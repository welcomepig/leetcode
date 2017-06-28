#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (MaximumSizeSubarray)

-(NSInteger)maximumSizeSubarray:(NSInteger)target;

@end

@implementation NSArray (MaximumSizeSubarray)

-(NSInteger)maximumSizeSubarray:(NSInteger)target
{
    if (self.count == 0) {
        return 0;
    }
    
    NSInteger i, sum, size, maxsize, valueToFind;
    NSMutableDictionary *sums = [NSMutableDictionary dictionary];
    
    sum = 0;
    sums[@(0)] = @(-1);
    maxsize = -1;
    
    for (i = 0;i < self.count; i++) {
        sum = sum + [self[i] integerValue];
        valueToFind = sum - target;
        
        if (sums[@(valueToFind)]) {
            size = i - [sums[@(valueToFind)] integerValue];
            maxsize = (size > maxsize) ? size : maxsize;
        }
        
        if (!sums[@(sum)]) {
            sums[@(sum)] = @(i);
        }
    }
    
    return (maxsize == -1) ? 0 : maxsize;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data1 = @[@(1), @(-1), @(5), @(-2), @(3)];
        NSLog(@"%ld", [data1 maximumSizeSubarray:3]);
        
        NSArray *data2 = @[@(-2), @(-1), @(2), @(1)];
        NSLog(@"%ld", [data2 maximumSizeSubarray:1]);
    }
}
