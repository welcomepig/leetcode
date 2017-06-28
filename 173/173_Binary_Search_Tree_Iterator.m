#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;

+(TreeNode*)deserialize:(NSString*)data;
-(NSString*)serialize;

@end

@implementation TreeNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
        _left = nil;
        _right = nil;
    }
    return self;
}

- (void)insert:(NSInteger)value
{
    if (value < self.value) {
        if (self.left) {
            [self.left insert:value];
        } else {
            self.left = [[TreeNode alloc] initWithValue:value];
        }
    } else {
        if (self.right) {
            [self.right insert:value];
        } else {
            self.right = [[TreeNode alloc] initWithValue:value];
        }
    }
}

-(void)paths:(NSMutableArray*)paths prefix:(NSString*)prefix
{
    NSString *newPrefix = [prefix isEqual:@""] ? [NSString stringWithFormat:@"%ld", self.value] :
                        [NSString stringWithFormat:@"%@->%ld", prefix, self.value];
    if (!self.left && !self.right) {
        [paths addObject:newPrefix];
        return;
    }
    
    [self.left paths:paths prefix:newPrefix];
    [self.right paths:paths prefix:newPrefix];
}

-(NSArray*)paths
{
    NSMutableArray *result = [NSMutableArray array];
    [self paths:result prefix:@""];
    return [result copy];
}

@end

@interface BSTIterator : NSObject

@property (nonatomic, strong) NSMutableArray *stack;

-(instancetype)initWithRoot:(TreeNode *)root;
-(BOOL)hasNext;
-(TreeNode *)next;

@end

@implementation BSTIterator

-(instancetype)initWithRoot:(TreeNode *)root
{
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        [self pushLefts:root];
    }
    return self;
}

-(void)pushLefts:(TreeNode *)root
{
    TreeNode *node = root;
    while (node) {
        [self.stack addObject:node];
        node = node.left;
    }
}

-(BOOL)hasNext
{
    return (self.stack.count > 0);
}

-(TreeNode *)next
{
    if (![self hasNext]) {
        return nil;
    }
    
    TreeNode *node = [self.stack lastObject];
    [self.stack removeLastObject];
    [self pushLefts:node.right];
    
    return node;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        TreeNode *root = [[TreeNode alloc] initWithValue:5];
        [root insert:3];
        [root insert:2];
        [root insert:4];
        [root insert:7];
        [root insert:6];
        [root insert:8];
        
        BSTIterator *it = [[BSTIterator alloc] initWithRoot:root];
        while ([it hasNext]) {
            NSLog(@"%ld", [it next].value);
        }
    }
}
