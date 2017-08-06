#import <Foundation/Foundation.h>

@interface NSString (IsValidParenthese)

- (BOOL)isValidParenthese;

@end

@implementation NSString (IsValidParenthese)

- (BOOL)isValidParenthese {
    NSMutableArray *stack = [NSMutableArray array];
    NSDictionary *map = @{ @('(') : @(')'), @('[') : @(']'), @('{') : @('}') };
    
    for (NSUInteger i = 0;i < self.length; i++) {
        char value = [self characterAtIndex:i];
        
        if (value == '(' || value == '[' || value == '{') {
            [stack addObject:map[@(value)]];
        } else if (value == ')' || value == ']' || value == '}') {
            if ([[stack lastObject] charValue] != value) {
                return NO;
            }
            [stack removeLastObject];
        }
    }
    
    return (stack.count == 0);
}

@end

int main(int argc, char * argv[]) {
    NSString *s = @"(()";
    NSLog(@"%d", [s isValidParenthese]);
}

