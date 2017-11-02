#import <Foundation/Foundation.h>

@interface NSArray (ExclusiveTime)

- (NSArray <NSNumber *>*)exclusiveTime:(NSUInteger)n;

@end

@implementation NSArray (ExclusiveTime)

- (NSArray <NSNumber *>*)exclusiveTime:(NSUInteger)n
{
    NSMutableArray *exTimes = [NSMutableArray arrayWithCapacity:n];
    NSMutableArray *stack = [NSMutableArray array];
    
    for (NSInteger i = 0;i < n; i++) {
        [exTimes addObject:@(0)];
    }
    
    NSInteger pre = 0;
    for (NSString *log in self) {
        NSArray *secs = [log componentsSeparatedByString:@":"];
        NSInteger time = [secs[2] integerValue];
        NSInteger currentID = [stack.lastObject integerValue];
        
        if ([secs[1] isEqual:@"start"]) {
            if (stack.count > 0) exTimes[currentID] = @([exTimes[currentID] integerValue] + time - pre);
            [stack addObject:secs[0]];
            pre = [secs[2] integerValue];
        } else {
            exTimes[currentID] = @([exTimes[currentID] integerValue] + time - pre + 1);
            [stack removeLastObject];
            pre = time + 1;
        }
    }
    
    return [exTimes copy];
}

@end

int main(int argc, char * argv[]) {
    NSArray *logs = @[@"0:start:2", @"1:start:3", @"1:end:5", @"0:end:8"];
    NSLog(@"%@", [logs exclusiveTime:2]);
    
    return 0;
}

