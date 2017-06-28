#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (RandomPickIndex)

-(NSUInteger)randomPickIndex:(NSInteger)target;

@end

@implementation NSArray (RandomPickIndex)

-(NSUInteger)randomPickIndex:(NSInteger)target
{
    NSUInteger index = 0;
    NSUInteger count = 0;
    
    for (NSUInteger i = 0;i < self.count; i++) {
        if ([self[i] integerValue] != target) {
            continue;
        }
        
        if (arc4random() % (++count) == 0) index = i;
    }
    
    return index;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(1), @(2), @(3), @(3), @(3)];
        NSLog(@"%ld", [data randomPickIndex:3]);
    }
}

