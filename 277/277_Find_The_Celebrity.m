#import <Foundation/Foundation.h>
#import <stdio.h>

@interface Celebrity : NSObject

@property (nonatomic, assign) NSInteger n;

-(instancetype)initWithPeople:(NSInteger)n;

@end

@implementation Celebrity

-(instancetype)initWithPeople:(NSInteger)n
{
    self = [super init];
    if (self) {
        _n = n;
    }
    return self;
}

-(BOOL)isA:(NSInteger)A knowB:(NSInteger)B
{
    return YES;
}

-(NSInteger)findCelebrity
{
    NSInteger candidate = 0;
    
    for (int i = 1; i < self.n; i++) {
        if (![self isA:i knowB:candidate]) {
            candidate = i;
        }
    }
    
    for (int i = 0;i < candidate; i++) {
        if (![self isA:i knowB:candidate]) {
            return -1;
        }
    }
    
    for (int i = 0;i < self.n; i++) {
        if (i == candidate) continue;
        if ([self isA:candidate knowB:i]) {
            return -1;
        }
    }
    
    return candidate;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
    }
}

