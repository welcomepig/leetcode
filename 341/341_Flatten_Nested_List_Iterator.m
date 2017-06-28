#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <stdio.h>

@interface NSMutableArray (Stack)

-(void)push:(id)object;
-(id)pop;

@end

@implementation NSMutableArray (Stack)

-(void)push:(id)object
{
    [self addObject:object];
}

-(id)pop
{
    id object = [self lastObject];
    [self removeLastObject];
    return object;
}

@end

@interface NestedInteger : NSObject

@property (nonatomic, strong) NSMutableArray *stack;

-(instancetype)initWithList:(NSArray*)list;
-(BOOL)hasNext;
-(NSNumber*)next;
-(NSArray*)allObjects;

@end

@implementation NestedInteger

-(instancetype)initWithList:(NSArray*)list
{
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        for (NSInteger i = list.count - 1;i >= 0; i--) {
            [_stack addObject:list[i]];
        }
    }
    return self;
}

-(BOOL)hasNext
{
    while (self.stack.count > 0) {
        if ([self.stack.lastObject isKindOfClass:[NSNumber class]]) {
            return YES;
        }
        
        NSArray *list = [self.stack pop];
        for (NSInteger i = list.count - 1;i >= 0; i--) {
            [self.stack push:list[i]];
        }
    }
    
    return NO;
}

-(NSNumber*)next
{
    return [self.stack pop];
}

-(NSArray*)allObjects
{
    NSMutableArray *result = [NSMutableArray array];
    while ([self hasNext]) {
        [result addObject:[self next]];
    }
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NestedInteger *nlist = [[NestedInteger alloc] initWithList:@[@[@(1), @(1)], @(2), @[@(1), @(1)]]];
        NSLog(@"%@", [nlist allObjects]);
    }
}
