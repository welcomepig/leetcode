#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNumber (ExcelColumn)

@end

@implementation NSNumber (ExcelColumn)

-(NSString*)excelColumn
{
    NSMutableString *result = [NSMutableString string];
    NSInteger value = [self integerValue];
    
    NSInteger a;
    
    while (value > 0) {
        aa = value % 26;
        [result insertString:(a == 0) ? @"" : [NSString stringWithFormat:@"%c", (char)('A' + a - 1)] atIndex:0];
        value = value / 26;
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%@", [@(28) excelColumn]);
    }
}

