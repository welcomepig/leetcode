#import <Foundation/Foundation.h>

BOOL isValidParentheses(NSString *s) {
    NSMutableArray *stack = [NSMutableArray array];

    for (NSUInteger i = 0;i < s.length; i++) {
        char c = [s characterAtIndex:i];
        switch (c) {
        case '(':
            [stack addObject:@(')')];
            break;
        case '[':
            [stack addObject:@(']')];
            break;
        case '{':
            [stack addObject:@('}')];
            break;
        case ')':
        case ']':
        case '}':
            if (stack.count == 0 || [stack.lastObject charValue] != c) return NO;
            [stack removeLastObject];
            break;
        }
    }
    
    return (stack.count == 0);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%d", isValidParentheses(@"(()"));
        NSLog(@"%d", isValidParentheses(@"[()]"));
        NSLog(@"%d", isValidParentheses(@"{}()[]"));
        NSLog(@"%d", isValidParentheses(@"({)}"));
    }
}

