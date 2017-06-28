#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSNode *next;

-(void)insert:(NSInteger)value;

@end

@implementation NSNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
        _next = nil;
    }
    return self;
}

-(void)insert:(NSInteger)value
{
    self.next = [[NSNode alloc] initWithValue:value];
}

@end

@interface NSList : NSObject

@property (nonatomic, strong) NSNode *root;

@end

@implementation NSList

-(instancetype)init
{
    self = [super init];
    if (self) {
        _root = nil;
    }
    return self;
}

-(NSString*)description
{
    NSMutableString *result = [NSMutableString string];
    NSNode *node = self.root;
    while (node) {
        [result appendFormat:@"%ld ", node.value];
        node = node.next;
    }
    return [result copy];
}

-(void)insert:(NSInteger)value
{
    if (!self.root) {
        self.root = [[NSNode alloc] initWithValue:value];
        return;
    }
    
    NSNode *node = self.root;
    while (node.next) {
        node = node.next;
    }
    [node insert:value];
}

-(void)reverse
{
    NSNode *prev, *next, *node = self.root;
    
    while (node) {
        next = node.next;
        node.next = prev;
        
        prev = node;
        node = next;
    }
    
    self.root = prev;
}

@end
 
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSList *list = [[NSList alloc] init];
        [list insert:5];
        [list insert:7];
        [list insert:3];
        [list insert:0];
        NSLog(@"%@", list);
        [list reverse];
        NSLog(@"%@", list);
    }
}
