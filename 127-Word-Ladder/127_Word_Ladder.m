#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (HamDist)

-(BOOL)isHamDistOne:(NSString*)b;

@end

@implementation NSString (HamDist)

-(BOOL)isHamDistOne:(NSString*)b
{
    int count = 0;
    
    for (int i = 0;i < self.length; i++) {
        if ([self characterAtIndex:i] != [b characterAtIndex:i]) {
            count++;
        }
        if (count > 1) return NO;
    }
    
    return (count == 1);
}

@end

@interface NSArray (WordLadder)

-(NSUInteger)minTransform:(NSString*)begin end:(NSString*)end;

@end

@implementation NSArray (WordLadder)

-(NSUInteger)minTransform:(NSString*)begin end:(NSString*)end
{
    NSUInteger num = 0;
    NSUInteger step = 1;
    NSMutableArray *dicts = [self mutableCopy];
    NSMutableArray *queue = [NSMutableArray array];
    
    [queue addObject:end];
    [dicts removeObject:end];
    
    while (queue.count > 0) {
        num = queue.count;
        
        for (NSUInteger i = 0;i < num; i++) {
            NSString *curWord = [queue firstObject];
            [queue removeObjectAtIndex:0];
        
            if ([curWord isHamDistOne:begin]) {
                return (step + 1);
            }
        
            /* method1: search all words in dictionary O(n * len) */
            /*for (NSString *word in [dicts copy]) {
                if ([word isHamDistOne:curWord]) {
                    [queue addObject:word];
                    [dicts removeObject:word];
                }
            }*/
            
            /* method2: search all possible O(26 * len) */
            for (NSUInteger j = 0;j < curWord.length; j++) {
                NSString *prefix = [curWord substringToIndex:j];
                NSString *suffix = [curWord substringFromIndex:(j+1)];
                for (NSUInteger c = 0;c < 26; c++) {
                    char letter = 'a' + c;
                    NSString *tmpWord = [NSString stringWithFormat:@"%@%c%@", prefix, letter, suffix];
                    if ([dicts containsObject:tmpWord]) {
                        [queue addObject:tmpWord];
                        [dicts removeObject:tmpWord];
                    }
                }
            }
        }
        
        step++;
    }
    
    return 0;
}

-(NSUInteger)minTransform2:(NSString*)begin end:(NSString*)end
{
    NSMutableArray *dicts = [self mutableCopy];
    NSMutableArray *head = [NSMutableArray array];
    NSMutableArray *tail = [NSMutableArray array];
    NSMutableArray *phead, *ptail;
    NSUInteger num = 0;
    NSUInteger step = 2;
    
    [head addObject:begin];
    [tail addObject:end];
    [dicts removeObject:end];
    
    while (head.count > 0 && tail.count > 0) {
        if (head.count <= tail.count) {
            phead = head;
            ptail = tail;
        } else {
            phead = tail;
            ptail = head;
        }
        
        
        num = phead.count;
        
        for (NSUInteger i = 0;i < num; i++) {
            NSString *curWord = [phead firstObject];
            [phead removeObjectAtIndex:0];
            
            for (NSUInteger j = 0;j < curWord.length; j++) {
                NSString *prefix = [curWord substringToIndex:j];
                NSString *suffix = [curWord substringFromIndex:(j+1)];
                for (NSUInteger c = 0;c < 26; c++) {
                    char letter = 'a' + c;
                    NSString *tmpWord = [NSString stringWithFormat:@"%@%c%@", prefix, letter, suffix];
                    
                    if ([ptail containsObject:tmpWord]) {
                        return step;
                    }
                    
                    if ([dicts containsObject:tmpWord]) {
                        [phead addObject:tmpWord];
                        [dicts removeObject:tmpWord];
                    }
                }
            }
        }
        
        step++;
    }
    
    return 0;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@"hot", @"dot", @"dog", @"lot", @"log", @"cog"];
        NSLog(@"%ld", [data minTransform2:@"hit" end:@"cog"]);
    }
}

