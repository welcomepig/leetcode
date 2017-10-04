#import <Foundation/Foundation.h>

@interface NSMutableArray (RemoveDuplicate)

- (NSUInteger)removeDuplicate;

@end

@implementation NSMutableArray (RemoveDuplicate)

- (NSUInteger)removeDuplicate
{
    if (self.count < 3) return self.count;
    
    NSInteger i = 2;
    NSInteger count = 0;
    
    while (i < self.count) {
        if ([self[i] isEqual:self[i-1]] && [self[i-1] isEqual:self[i-2]]) {
            count++;
        } else {
            self[i-count] = self[i];
        }
        i++;
    }
    [self removeObjectsInRange:NSMakeRange(self.count - count, count)];
    
    return self.count;
}

- (NSUInteger)removeDuplicate:(NSUInteger)k
{
    if (self.count <= k) return self.count;
    
    NSInteger i = 1;    // point to place to write next time
    NSInteger j = 1;    // point to current
    NSInteger cnt = 1;  // counter of same object
    
    while (j < self.count) {
        if (![self[j] isEqual:self[j-1]]) {
            self[i++] = self[j];
            cnt = 1;
        } else if (cnt < k) {
            self[i++] = self[j];
            cnt++;
        }
        
        j++;
    }
    
    [self removeObjectsInRange:NSMakeRange(i, self.count - i)];
    
    return i;
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
    NSLog(@"%lu %@", [data removeDuplicate:2], data);
}
