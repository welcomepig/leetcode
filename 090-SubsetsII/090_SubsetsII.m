#import <Foundation/Foundation.h>

@interface NSArray (SubsetsII)

- (NSArray*)subsets;

@end

@implementation NSArray (SubsetsII)

- (NSArray*)subsets
{
    NSMutableArray *subsets = [NSMutableArray array];
    NSInteger i, size, preSize = 0;
    id preObj = nil;

    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    [subsets addObject:@[]];
    for (id obj in sorted) {
        size = subsets.count;
        i = [obj isEqual:preObj] ? 0 : preSize; 
        for (;i < size; i++) {
            NSMutableArray *row = [subsets[i] mutableCopy];
            [row addObject:obj];
            [subsets addObject:row];
        }
        
        preObj = obj;
        preSize = size;
    }
    
    return [subsets copy];
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%@", [@[@(1), @(2), @(2)] subsets]);
}
