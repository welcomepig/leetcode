#import <Foundation/Foundation.h>

@interface NSArray (InsertRange)

- (NSArray*)insertedRange:(NSRange)range;

@end

@implementation NSArray (InsertRange)

- (NSArray*)insertedRange:(NSRange)range
{
    NSMutableArray *result = [NSMutableArray array];
    NSRange r;
    NSInteger i = 0, s = range.location, e = range.location + range.length;
    
    while (i < self.count) {
        r = [self[i] rangeValue];
        if (r.location + r.length >= range.location) {
            break;
        }
        [result addObject:[NSValue valueWithRange:r]];
        i++;
    }
    
    while (i < self.count) {
        r = [self[i] rangeValue];
        if (e < r.location) {
            break;
        }
        
        s = MIN(r.location, s);
        e = MAX(r.location + r.length, e);
        i++;
    }
    [result addObject:[NSValue valueWithRange:NSMakeRange(s, e - s)]];
    
    while (i < self.count) {
        r = [self[i] rangeValue];
        [result addObject:[NSValue valueWithRange:r]];
        i++;
    }
    
    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    NSArray *data1 = @[[NSValue valueWithRange:NSMakeRange(1, 5 - 1)]];
    NSLog(@"%@", [data1 insertedRange:NSMakeRange(2, 3 - 2)]);
    
    NSArray *data2 = @[[NSValue valueWithRange:NSMakeRange(1, 3 - 1)],
                       [NSValue valueWithRange:NSMakeRange(6, 9 - 6)]];
    NSLog(@"%@", [data2 insertedRange:NSMakeRange(2, 5 - 2)]);

    NSArray *data3 = @[[NSValue valueWithRange:NSMakeRange(1, 2 - 1)],
                       [NSValue valueWithRange:NSMakeRange(3, 5 - 3)],
                       [NSValue valueWithRange:NSMakeRange(6, 7 - 6)],
                       [NSValue valueWithRange:NSMakeRange(8, 10 - 8)],
                       [NSValue valueWithRange:NSMakeRange(12, 16 - 12)]];
    NSLog(@"%@", [data3 insertedRange:NSMakeRange(4, 9 - 4)]);
}
