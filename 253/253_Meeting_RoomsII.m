#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSInterval : NSObject

@property (nonatomic, assign) NSUInteger start;
@property (nonatomic, assign) NSUInteger end;

-(instancetype)initWithStart:(NSUInteger)start end:(NSUInteger)end;

@end

@implementation NSInterval

-(instancetype)initWithStart:(NSUInteger)start end:(NSUInteger)end
{
    self = [super init];
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}

@end

@interface NSArray (MeetingRooms)

-(NSUInteger)minMeetingRooms;

@end

@implementation NSArray (MeetingRooms)

-(NSUInteger)minMeetingRooms
{
    if (self.count == 0) {
        return 0;
    }
    
    NSMutableArray *starts = [NSMutableArray array];
    NSMutableArray *ends = [NSMutableArray array];
    
    for (int i = 0;i < self.count; i++) {
        NSArray *interval = self[i];
        
        [starts addObject:interval[0]];
        [ends addObject:interval[1]];
    }
    
    NSArray *sortStarts = [starts sortedArrayUsingSelector:@selector(compare:)];
    NSArray *sortEnds = [ends sortedArrayUsingSelector:@selector(compare:)];
    
    NSInteger numRooms = 0;
    NSInteger availableRooms = 0;
    
    int i, j;
    while (i < sortStarts.count) {
        if ([(NSNumber*)sortStarts[i] intValue] <= [(NSNumber*)sortEnds[j] intValue]) {
            // start a meeting
            if (availableRooms == 0) {
                numRooms++;
            } else {
                availableRooms--;
            }
            i++;
        } else {
            // end a meeting
            availableRooms++;
            j++;
        }
    }
    
    return numRooms;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *intervals = @[@[@(15), @(20)], @[@(5), @(10)], @[@(0), @(30)]];
        NSLog(@"%lu", [intervals minMeetingRooms]);
    }
}

