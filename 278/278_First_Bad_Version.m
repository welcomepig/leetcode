#import <Foundation/Foundation.h>
#import <stdio.h>

@interface FirstBadVersion : NSObject

+ (BOOL)isBadVersion:(NSUInteger)n;
+ (NSUInteger)firstBadVersion:(NSUInteger)n;

@end
    
@implementation FirstBadVersion : NSObject

+ (BOOL)isBadVersion:(NSUInteger)n
{
    return (n >= 5);
}

+ (NSUInteger)firstBadVersion:(NSUInteger)n
{
    NSUInteger start, end, mid;
    start = 1;
    end = n;
 
    while (start < end) {
        // point!! prevent from overflow
        mid = start + (end - start) / 2;
        if ([FirstBadVersion isBadVersion:mid]) {
            end = mid;
        } else {
            start = mid + 1;
        }
    }
    
    // return min will be failed at n = 1
    return end;
}


@end

    
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSLog(@"%lu", [FirstBadVersion firstBadVersion:5]);
    }
}

