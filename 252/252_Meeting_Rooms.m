#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (MeetingRooms)

-(BOOL)couldAttendAllMeetings;
-(BOOL)couldAttendAllMeetings2;

@end

@implementation NSArray (MeetingRooms)

-(BOOL)couldAttendAllMeetings
{
    for (int i = 0;i < self.count; i++) {
        NSArray *data1 = (NSArray *)self[i];
        for (int j = i + 1;j < self.count; j++) {
            NSArray *data2 = (NSArray *)self[j];
            
            if ([(NSNumber*)data2[0] intValue] > [(NSNumber*)data1[1] intValue] ||
                [(NSNumber*)data2[1] intValue] < [(NSNumber*)data1[0] intValue]) {
            } else {
                return NO;
            }
        }
    }
    
    return YES;
}

- (NSComparisonResult)compare:(NSArray*)other {
    return [self[0] compare:other[0]];
}

-(BOOL)couldAttendAllMeetings2
{
    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    
    for (int i = 1;i < sorted.count; i++) {
        NSArray *data1 = (NSArray *)sorted[i - 1];
        NSArray *data2 = (NSArray *)sorted[i];
        
        if ([(NSNumber*)data1[0] intValue] == [(NSNumber*)data2[0] intValue] ||
            [(NSNumber*)data2[0] intValue] < [(NSNumber*)data1[1] intValue]) {
            // point2's start < point1's end
            return NO;
        }
    }
    
    return YES;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *intervals = @[@[@(15), @(20)], @[@(5), @(10)], @[@(0), @(30)]];
        NSLog(@"%d", [intervals couldAttendAllMeetings2]);
    }
}

