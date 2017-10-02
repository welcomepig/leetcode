#import <Foundation/Foundation.h>

@interface Meeting : NSObject

@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger end;

- (instancetype)initWithStart:(NSInteger)start end:(NSInteger)end;
+ (BOOL)canAttendAllMeetings:(NSArray <Meeting*>*)meetings;

@end

@implementation Meeting

- (instancetype)initWithStart:(NSInteger)start end:(NSInteger)end
{
    self = [super init];
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}

+ (BOOL)canAttendAllMeetings:(NSArray <Meeting*>*)meetings
{
    if (meetings.count == 0) return YES;
    
    NSArray *sorted = [meetings sortedArrayUsingComparator:^NSComparisonResult(Meeting *a, Meeting *b){
        if (a.start < b.start) {
            return NSOrderedAscending;
        } else if (a.start > b.start) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    Meeting *cur;
    Meeting *pre = sorted[0];
    for (int i = 1;i < sorted.count; i++) {
        cur = sorted[i];
        if (cur.start <= pre.end) {
            return NO;
        }
        pre = cur;
    }

    return YES;
}

@end

int main(int argc, char * argv[]) {
    Meeting *m1 = [[Meeting alloc] initWithStart:15 end:20];
    Meeting *m2 = [[Meeting alloc] initWithStart:5 end:10];
    Meeting *m3 = [[Meeting alloc] initWithStart:22 end:30];
    NSLog(@"%d", [Meeting canAttendAllMeetings:@[m1, m2, m3]]);
}
