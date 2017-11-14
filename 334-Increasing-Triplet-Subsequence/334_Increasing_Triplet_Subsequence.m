#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (IncreasingTriplet)

-(BOOL)isIncreasingTripletSubsequenceExist;

@end

@implementation NSArray (IncreasingTriplet)

-(BOOL)isIncreasingTripletSubsequenceExist
{
    NSInteger x = 0;
    NSInteger e1 = NSIntegerMax, e2 = NSIntegerMax;
    
    for (int i = 0;i < self.count; i++) {
        x = [self[i] integerValue];
        
        if (x <= e1) {
            e1 = x;
        } else if (x <= e2) {
            e2 = x;
        } else {
            return YES;
        }
    }
    
    return NO;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@(2), @(6), @(3), @(7)];
        NSLog(@"%d", [data isIncreasingTripletSubsequenceExist]);
        
        NSArray *data2 = @[@(2), @(6), @(3)];
        NSLog(@"%d", [data2 isIncreasingTripletSubsequenceExist]);
    }
}

