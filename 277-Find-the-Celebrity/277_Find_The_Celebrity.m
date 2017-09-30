#import <Foundation/Foundation.h>

@interface FindCelebrity : NSObject

- (NSInteger)findCelebrity:(NSInteger)n;

@end

@implementation FindCelebrity

- (BOOL)isKnows:(NSInteger)a b:(NSInteger)b
{
    return YES;
}

- (NSInteger)findCelebrity:(NSInteger)n
{
    if (n < 2) return -1;
    
    NSInteger i, candidate = 0;
    
    for (i = 1;i < n; i++) {
        if ([self isKnows:candidate b:i]) {
            candidate = i;
        }
    }
    
    for (i = 0;i < n; i++) {
        if (candidate == i) continue;
        
        if ([self isKnows:candidate b:i] || ![self isKnows:i b:candidate]) {
            return -1;
        }
    }
    
    return candidate;
}

@end


int main(int argc, char * argv[]) {

}

