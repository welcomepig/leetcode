#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (ValidParentheses)

-(BOOL)isValidParentheses;

@end

@implementation NSString (ValidParentheses)

-(BOOL)isValidParentheses
{
    NSMutableArray *stack = [NSMutableArray array];
    
    for (int i = 0;i < self.length; i++) {
        char c = [self characterAtIndex:i];
        
        if (c == '(' || c == '{' || c == '[') {
            [stack addObject:@(c)];
        } else if (c == ')' || c == '}' || c == ']') {
            char lc = [[stack lastObject] charValue];
            if ((lc == '(' && c == ')') || (lc == '[' && c == ']') || (lc == '{' && c == '}')) {
                [stack removeLastObject];
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    }
    
    return (stack.count == 0);
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *str = @"{}";
        NSLog(@"%d", [str isValidParentheses]);
    }
}

