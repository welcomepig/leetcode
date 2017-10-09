#import <Foundation/Foundation.h>

@interface NSMutableArray (MoveZero)

- (NSUInteger)moveZero;

@end

@implementation NSMutableArray (MoveZero)

- (NSUInteger)moveZero
{
    NSUInteger i = 0;   // first zero
    
    for (NSUInteger j = 0;j < self.count; j++) {
        if ([self[j] integerValue] != 0) {
            [self exchangeObjectAtIndex:i++
                      withObjectAtIndex:j];
        }
    }
    
    return (self.count - i);
}

- (NSUInteger)moveZeroUnorder
{
    NSInteger i = 0;               // first zero
    NSInteger j = self.count - 1;  // last non-zero
    
    while (i <= j) {
        if ([self[i] integerValue] != 0) {
            i++;
            continue;
        }
        
        if ([self[j] integerValue] == 0) {
            j--;
            continue;
        }
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];
        i++; j--;
    }
    
    return (self.count - i);
}

@end

int main(int argc, char * argv[]) {
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@(4), @(0), @(3), @(0), @(7), nil];
    NSLog(@"%lu %@", [ary moveZero], ary);
    NSMutableArray *data = [NSMutableArray arrayWithArray:@[@(4),@(3),@(0),@(1),@(2),@(0)]];
    NSLog(@"%lu %@", [data moveZeroUnorder], data);
    NSMutableArray *data2 = [NSMutableArray arrayWithArray:@[@(0),@(0),@(0),@(0),@(0)]];
    NSLog(@"%lu %@", [data2 moveZeroUnorder], data2);
    NSMutableArray *data3 = [NSMutableArray arrayWithArray:@[@(7),@(9),@(1),@(5),@(2)]];
    NSLog(@"%lu %@", [data3 moveZeroUnorder], data3);
}
