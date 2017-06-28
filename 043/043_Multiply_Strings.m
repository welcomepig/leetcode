#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (Multiply)

-(NSString*)multiply:(NSString*)str;

@end

@implementation NSString (Multiply)

-(NSString*)multiply:(NSString*)str
{
    NSMutableString *result = [NSMutableString string];
    NSInteger i, j, vi, vj, v, value[self.length + str.length];
    
    for (i = 0;i < self.length + str.length; i++) {
        value[i] = 0;
    }
    
    for (i = self.length - 1;i >= 0; i--) {
        vi = [self characterAtIndex:i] - '0';
        for (j = str.length - 1;j >= 0; j--) {
            vj = [self characterAtIndex:j] - '0';
            v = vi * vj + value[i+j+1];
            value[i+j+1] = v % 10;
            value[i+j] += v / 10;
        }
    }
    
    i = 0;
    while (i < self.length + str.length && value[i] == 0) {
        i++;
    }
    
    for (;i < self.length + str.length; i++) {
        [result appendFormat:@"%ld", value[i]];
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%@", [@"99" multiply:@"99"]);
    }
}

