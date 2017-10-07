#import <Foundation/Foundation.h>

@interface NSMutableArray (RemoveDuplicate)

- (NSUInteger)removeDuplicate;

@end

@implementation NSMutableArray (RemoveDuplicate)

- (NSUInteger)removeDuplicate
{
    if (self.count == 0) return 0;
    
    NSInteger i = 1;
    while (i < self.count) {
        if ([self[i] isEqual:self[i-1]]) {
            [self removeObjectAtIndex:i];
        } else {
            i++;
        }
    }

    return self.count;
}

- (NSUInteger)removeDuplicateII
{
    if (self.count == 0) return 0;
    
    NSInteger i = 1;
    NSInteger count = 0;
    
    while (i < self.count) {
        if ([self[i] isEqual:self[i-1]]) {
            count++;
        } else {
            self[i - count] = self[i];
        }
        i++;
    }
    [self removeObjectsInRange:NSMakeRange(self.count - count, count)];
     
    return self.count;
}

@end

int main(int argc, char * argv[]) {
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:@(0)];
    [data addObject:@(0)];
    [data addObject:@(0)];
    [data addObject:@(1)];
    [data addObject:@(2)];
    [data addObject:@(2)];
    NSLog(@"%lu %@", [data removeDuplicateII], data);
}
