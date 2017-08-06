#import <Foundation/Foundation.h>

@interface NSArray (FindDuplicate)

- (BOOL)findDuplicateII:(NSInteger)k;

@end

@implementation NSArray (FindDuplicate)

- (BOOL)findDuplicateII:(NSInteger)k {
    if (k <= 0) return NO;
    if (k >= self.count) k = self.count - 1;
    
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    NSUInteger i = 0;
    for (NSNumber *num in self) {
        if (hash[num] && (i - [hash[num] integerValue] <= k)) {
            return YES;
        }
        [hash setObject:@(i) forKey:num];
        i++;
    }
    return NO;
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%d", [@[@(1), @(4), @(7), @(7)] findDuplicateII:3]);
}

