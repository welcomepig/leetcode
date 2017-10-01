#import <Foundation/Foundation.h>

@interface NSArray (Subsets)

- (NSArray*)subsets;

@end

@implementation NSArray (Subsets)

- (NSArray*)subsets
{
    NSMutableArray *subsets = [NSMutableArray array];
    NSUInteger size;
    
    [subsets addObject:@[]];
    for (id obj in self) {
        size = subsets.count;
        
        for (int i = 0;i < size; i++) {
            NSMutableArray *row = [subsets[i] mutableCopy];
            [row addObject:obj];
            [subsets addObject:[row copy]];
        }
    }
    
    return [subsets copy];
}

@end

int main(int argc, char * argv[]) {
    NSLog(@"%@", [@[@(1), @(2), @(3)] subsets]);
}
