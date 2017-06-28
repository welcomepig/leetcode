#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTreeNode : NSObject

@property (nonatomic, assign) int value;
@property (nonatomic, strong) NSTreeNode *left;
@property (nonatomic, strong) NSTreeNode *right;

- (id)initWithValue:(int)value;
- (void)insertNode:(int)value;

@end

@implementation NSTreeNode

- (id)initWithValue:(int)value
{
    self = [super init];
    if (self) {
        self.value = value;
        self.left = nil;
        self.right = nil;
    }
    return self;
}
    
- (void)insertNode:(int)value
{
    if (value < self.value) {
        if (self.left) {
            [self.left insertNode:value];
        } else {
            NSTreeNode *node = [[NSTreeNode alloc] initWithValue:value];
            self.left = node;
        }
    } else {
        if (self.right) {
            [self.right insertNode:value];
        } else {
            NSTreeNode *node = [[NSTreeNode alloc] initWithValue:value];
            self.right = node;
        }
    }
}
    
@end
    
@interface NSTree : NSObject

@property (nonatomic, strong) NSTreeNode *root;

- (void)insertNode:(int)value;
+ (void)printPathToChild:(NSTreeNode *)node path:(NSString *)path;

@end

@implementation NSTree
   
- (id)init
{
    self = [super init];
    if (self) {
        self.root = nil;
    }
    return self;
}

- (void)insertNode:(int)value
{
    if (self.root) {
        [self.root insertNode:value];
    } else {
        NSTreeNode *node = [[NSTreeNode alloc] initWithValue:value];
        self.root = node;
    }
}

+ (void)printPathToChild:(NSTreeNode *)node path:(NSString *)path
{
    if (!node) {
        return;
    }
    
    NSString *newPath = (path.length == 0) ? [NSString stringWithFormat:@"%d", node.value]
                        : [NSString stringWithFormat:@"%@->%d", path, node.value];
    
    if (!node.left && !node.right) {
        NSLog(@"%@", newPath);
        return;
    }
    
    if (node.left) {
        [NSTree printPathToChild:node.left path:newPath];
    }
    
    if (node.right) {
        [NSTree printPathToChild:node.right path:newPath];
    }
}
    
@end
    
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSTree *tree = [[NSTree alloc] init];
        [tree insertNode:4];
        [tree insertNode:2];
        [tree insertNode:6];
        [tree insertNode:1];
        [NSTree printPathToChild:tree.root path:@""];
    }
}

