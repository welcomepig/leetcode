#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <stdio.h>

@interface NSString (PhoneLetters)

+(NSArray*)letters;
-(NSArray*)phoneLetters;

@end

@implementation NSString (PhoneLetters)

+(NSArray*)letters
{
    static NSArray *letters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        letters = @[@[], @[], @[@"a", @"b", @"c"], @[@"d", @"e", @"f"],
                  @[@"g", @"h", @"i"], @[@"j", @"k", @"l"], @[@"m", @"n", @"o"],
                  @[@"p", @"q", @"r", @"s"], @[@"t", @"u", @"v"], @[@"w", @"x", @"y", @"z"]];
    });
    return letters;
}

-(NSArray*)phoneLetters
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *letters;
    NSInteger i, j, k, count;
    
    for (i = 0;i < self.length; i++) {
        count = result.count;
        letters = [NSString letters][[self characterAtIndex:i] - '0'];
        
        if (count == 0) {
            [result addObjectsFromArray:letters];
            continue;
        }
        
        for (j = 0;j < letters.count; j++) {
            for (k = 0;k < count; k++) {
                [result addObject:[NSString stringWithFormat:@"%@%@", result[k], letters[j]]];
            }
        }
        [result removeObjectsInRange:NSMakeRange(0, count)];
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%@", [@"23" phoneLetters]);
    }
}


