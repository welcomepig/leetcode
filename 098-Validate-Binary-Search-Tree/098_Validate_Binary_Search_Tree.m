#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSNode *left;
@property (nonatomic, strong) NSNode *right;

- (instancetype)initWithValue:(NSInteger)value;
- (void)insert:(NSInteger)value;

@end

@implementation NSNode
    
- (instancetype)initWithValue:(NSInteger)value
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
    
@interface NSBSTree : NSObject

@property (nonatomic, assign) bool isLefMostNode;
@property (nonatomic, assign) NSInteger preval;
@property (nonatomic, strong) NSNode *root;

- (void)insert:(NSInteger)value;
- (bool)isBSTValid;
- (bool)isBSTValid:(NSNode*)node;

@end

@implementation NSBSTree
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLefMostNode = false;
        _preval = NSIntegerMin;
        _root = nil;
    }
    return self;
}
    
- (void)insert:(NSInteger)value
{
    if (self.root) {
        [self.root insert:value];
    } else {
        self.root = [[NSNode alloc] initWithValue:value];
    }
}

- (bool)isBSTValid
{
    return [self isBSTValid:self.root];
}

- (bool)isBSTValid:(NSNode*)node
{
    // inorder traverse
    if (!node) {
        return true;
    }
    
    if (!node.left && !node.right && self.isLefMostNode) {
        self.isLefMostNode = false;
        return true;
    }
    
    // check left
    if (node.left && ![self isBSTValid:node.left]) {
        return false;
    }
    
    // check parent
    if (self.preval >= node.value) {
        return false;
    }
    self.preval = node.value;
    
    // check right
    if (node.right && ![self isBSTValid:node.right]) {
        return false;
    }
    
    return true;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSBSTree *bstree = [[NSBSTree alloc] init];
        [bstree insert:4];
        [bstree insert:2];
        [bstree insert:7];
        NSLog(@"%d", [bstree isBSTValid]);
    }
}
