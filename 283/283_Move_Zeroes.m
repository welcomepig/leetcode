#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (MoveZeros)

- (NSUInteger)moveZeros;

@end
    
@implementation NSMutableArray (MoveZeros)

- (NSUInteger)moveZeros
{
    // i: point to frontest zero pos
    // j: current pos
    NSUInteger i = 0, j = 0;
    
    while (j < self.count) {
        // handle object which is not NSNumber
        if ([self[j] isKindOfClass:[NSNumber class]]) {
            NSInteger value = [(NSNumber*)self[j] intValue];
            
            if (value != 0) {
                // swap
                NSNumber *tmp = self[j];
                self[j] = self[i];
                self[i] = tmp;
                i++;
            }
        }
        j++;
    }
    
    return (self.count - i);
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableArray *ary = [NSMutableArray arrayWithObjects:@(4), @(0), @(3), @(0), @(7), nil];
        NSLog(@"%lu", [ary moveZeros]);
        NSLog(@"%@", ary);
    }
}
