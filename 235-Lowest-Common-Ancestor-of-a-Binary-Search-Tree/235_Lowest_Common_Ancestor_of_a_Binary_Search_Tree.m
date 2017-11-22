#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;

-(TreeNode*)findCommonAncestor:(NSInteger)a b:(NSInteger)b;

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

-(TreeNode*)findSuccessor:(NSInteger)value
{
    TreeNode *node = self;
    TreeNode *sucnode = nil;
    
    while (value != node.value && node) {
        if (value < node.value) {
            sucnode = node;
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
    if (node.right) {
        node = node.right;
        sucnode = node;
        
        while (node.left) {
            node = node.left;
            sucnode = node;
        }
    }
    
    return node;
}

-(TreeNode*)findCommonAncestor:(NSInteger)a b:(NSInteger)b
{
    TreeNode *node = self;
    
    while (node) {
        if (node.value == a || node.value == b) {
            return node;
        }
        if ((b < node.value && a > node.value) || (a < node.value && b > node.value)) {
            return node;
        }
        
        if (a < node.value && b < node.value) {
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
    return nil;
}

-(TreeNode*)findCommonAncestor2:(NSInteger)a b:(NSInteger)b
{
    TreeNode *node = self;
    
    while ((node.value - a) * (node.value - b) > 0) {
        if (a < node.value) {
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
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
        NSLog(@"%ld", [root findCommonAncestor:2 b:5].value);
        NSLog(@"%ld", [root findCommonAncestor2:2 b:5].value);
    }
}
