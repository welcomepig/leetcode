#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNode : NSObject
    
@property (nonatomic, assign) int value;
@property (nonatomic, strong) NSNode *left;
@property (nonatomic, strong) NSNode *right;

- (instancetype)initWithValue:(int)value;
- (void)insert:(int)value;

@end
    
@implementation NSNode

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _left = nil;
        _right = nil;
    }
    
    return self;
}

- (instancetype)initWithValue:(int)value
{
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (void)insert:(int)value
{
    if (value < self.value) {
        if (self.left) {
            [self.left insert:value];
        } else {
            self.left = [[NSNode alloc] initWithValue:value];
        }
    } else {
        if (self.right) {
            [self.right insert:value];
        } else {
            self.right = [[NSNode alloc] initWithValue:value];
        }
    }
}

@end
    
@interface NSTree : NSObject
    
@property (nonatomic, strong) NSNode *root;

+ (bool)isNode:(NSNode*)a EqualTo:(NSNode*)b;
- (void)insert:(int)value;

@end
    
@implementation NSTree
    
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _root = nil;
    }
    
    return self;
}

- (void)insert:(int)value
{
    if (self.root) {
        [self.root insert:value];
    } else {
        self.root = [[NSNode alloc] initWithValue:value];
    }
}

+ (bool)isNode:(NSNode*)a EqualTo:(NSNode*)b
{
    if (!a && !b) {
        return true;
    }
    
    if (!a || !b || a.value != b.value) {
        return false;
    }
    
    return [NSTree isNode:a.left EqualTo:b.left] && [NSTree isNode:a.right EqualTo:b.right];
}

-(BOOL)isEqual:(NSNode*)node
{
    if (!node) return NO;
    if (self.value != node.value) return NO;
    
    BOOL isLeftEqual = (!self.left && !node.left) ? YES : [self.left isEqual:node.left];
    BOOL isRightEqual = (!self.right && !node.right) ? YES : [self.right isEqual:node.right];
    return isLeftEqual && isRightEqual;
}

@end
    
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSTree *tree1 = [[NSTree alloc] init];
        [tree1 insert:3];
        [tree1 insert:1];
        [tree1 insert:8];
        
        NSTree *tree2 = [[NSTree alloc] init];
        [tree2 insert:3];
        [tree2 insert:8];
        [tree2 insert:1];
        
        NSLog(@"%d", [NSTree isNode:tree1.root EqualTo:tree2.root]);
    }
}

