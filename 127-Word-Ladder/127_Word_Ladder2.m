#import <Foundation/Foundation.h>

BOOL canTransformed(NSString *a, NSString *b) {
    if (a.length != b.length) return NO;
    
    NSInteger count = 0;
    for (NSInteger i = 0;i < a.length; i++) {
        if ([a characterAtIndex:i] - [b characterAtIndex:i] == 0) continue;
        if (count > 1) return NO;
        count++;
    }
    return (count == 1);
}

NSUInteger ladderLengthMutableWords(NSString *begin, NSString *end, NSMutableArray *words) {
    NSUInteger count, length = 1;
    NSMutableArray *currents = [NSMutableArray array];
    
    [currents addObject:begin];    
    while (currents.count > 0) {
        count = currents.count;
        for (NSInteger i = 0;i < count; i++) {
            for (NSInteger j = words.count - 1;j >= 0; j--) { 
                if (canTransformed(currents[i], words[j])) {
                    if ([words[j] isEqual:end]) return (length + 1);
                    [currents addObject:words[j]];
                    [words removeObjectAtIndex:j];
                }
            }
        }
        length++;
        [currents removeObjectsInRange:NSMakeRange(0, count)];
    }
    return 0;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSArray *data = @[@"hot", @"dot", @"dog", @"lot", @"log", @"cog"];
        NSLog(@"%ld", ladderLengthMutableWords(@"hit", @"cog", [data mutableCopy]));
    }
}

