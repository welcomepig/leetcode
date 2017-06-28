#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (RemoveDuplicate)

- (void)removeDuplicate;
- (void)removeDuplicateInplace;

@end
    
@implementation NSMutableArray (RemoveDuplicate)

- (void)removeDuplicate
{
    NSUInteger i = 0;
    while (i < self.count) {
        NSInteger current = [(NSNumber*)self[i] intValue];
        if (i + 1 < self.count && 
            current == [(NSNumber*)self[i+1] intValue]) {
            [self removeObjectAtIndex:i+1];
            // [self removeObject:self[i+1]] failed
            // => Removes all occurrences in the array of a given object.
            // it will remove same-value elements (same address)
        } else {
            i++;
        }
    }
}

- (void)removeDuplicateInplace
{
    NSUInteger i = 1;
    NSUInteger count = 0;
    
    while (i < self.count) {
        if ([(NSNumber*)self[i] intValue] == [(NSNumber*)self[i-1] intValue]) {
            count++;
        } else {
           self[i-count] = self[i];
        }
        i++;
    }
    
    [self removeObjectsInRange:(NSRange){count, self.count - count}];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableArray *data1 = [NSMutableArray arrayWithObjects:@(1), @(1), @(1), @(2), @(3), @(3), nil];
        NSLog(@"%@", data1);
        [data1 removeDuplicateInplace];
        NSLog(@"%@", data1);
    }
}

