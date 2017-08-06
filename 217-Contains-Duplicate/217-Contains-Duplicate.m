#import <Foundation/Foundation.h>

@interface NSArray (FindDuplicate)

- (BOOL)findDuplicate;

@end

@implementation NSArray (FindDuplicate)

- (BOOL)findDuplicate {
    NSMutableSet *hash = [NSMutableSet set];
    
    for (NSNumber *num in self) {
        if ([hash containsObject:num]) {
            return YES;
        }
        [hash addObject:num];
    }
    return NO;
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%d", [@[@(1), @(4), @(7), @(7)] findDuplicate]);
}

