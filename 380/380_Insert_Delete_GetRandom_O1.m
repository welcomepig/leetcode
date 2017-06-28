#import <Foundation/Foundation.h>
#import <stdio.h>

@interface RandomizedSet : NSObject

@property (nonatomic, strong) NSMutableDictionary *map;
@property (nonatomic, strong) NSMutableArray *list;

-(BOOL)insert:(NSInteger)value;
-(BOOL)remove:(NSInteger)value;
-(NSInteger)getRandom;

@end

@implementation RandomizedSet

-(instancetype)init
{
    self = [super init];
    if (self) {
        _map = [NSMutableDictionary dictionary];
        _list = [NSMutableArray array];
    }
    return self;
}

-(BOOL)insert:(NSInteger)value
{
    if (self.map[@(value)]) {
        return NO;
    }
    [self.list addObject:@(value)];
    self.map[@(value)] = @(self.list.count - 1);
    return YES;
}

-(BOOL)remove:(NSInteger)value
{
    if (!self.map[@(value)]) {
        return NO;
    }
    NSInteger idx = [self.map[@(value)] integerValue];
    if (idx != self.list.count - 1) {
        self.list[idx] = self.list[self.list.count - 1];
        self.map[self.list[idx]] = @(idx);
    }
    [self.list removeLastObject];
    [self.map removeObjectForKey:@(value)];
    return YES;
}

-(NSInteger)getRandom
{
    NSInteger idx = arc4random() % self.list.count;
    return [self.list[idx] integerValue];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        RandomizedSet *set = [[RandomizedSet alloc] init];
        NSLog(@"%d", [set insert:1]);
        NSLog(@"%d", [set remove:2]);
        NSLog(@"%d", [set insert:2]);
        NSLog(@"%ld", [set getRandom]);
        NSLog(@"%d", [set remove:1]);
        NSLog(@"%d", [set insert:2]);
        NSLog(@"%ld", [set getRandom]);
    }
}

