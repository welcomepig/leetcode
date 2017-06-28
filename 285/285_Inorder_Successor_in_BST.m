#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTreeNode : NSObject

@property (nonatomic, strong) NSTreeNode *left;
@property (nonatomic, strong) NSTreeNode *right;
@property (nonatomic, assign) NSInteger value;

-(instancetype)initWithValue:(NSInteger)value;
-(NSTreeNode*)inorderSuccessor:(NSInteger)value;
-(NSTreeNode*)inorderSuccessor2:(NSInteger)value;

@end

@implementation NSTreeNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

-(NSTreeNode*)inorderSuccessor:(NSInteger)value
{
    NSTreeNode *node = self;
    NSTreeNode *rparent = nil;
    
    while (node) {
        if (node.value == value) {
            // 1.left most node of right
            if (node.right) {
                node = node.right;
                while (node.left) {
                    node = node.left;
                }
                return node;
            }
            // 2.last right parent
            if (rparent) {
                return rparent;
            }
            return nil;
        } else if (value < node.value) {
            rparent = node;
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
    return nil;
}

/* O(h) where h is depth of node */
-(NSTreeNode*)inorderSuccessor2:(NSInteger)value
{
    NSTreeNode *node = self;
    NSTreeNode *succ = nil;
    
    while (node) {
        if (value < node.value) {
            succ = node;
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
    return succ;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSTreeNode *node1 = [[NSTreeNode alloc] initWithValue:1];
        NSTreeNode *node5 = [[NSTreeNode alloc] initWithValue:5];
        NSTreeNode *node7 = [[NSTreeNode alloc] initWithValue:7];
        NSTreeNode *node8 = [[NSTreeNode alloc] initWithValue:8];
        NSTreeNode *node10 = [[NSTreeNode alloc] initWithValue:10];
        NSTreeNode *node15 = [[NSTreeNode alloc] initWithValue:15];
        NSTreeNode *node17 = [[NSTreeNode alloc] initWithValue:17];
        NSTreeNode *node20 = [[NSTreeNode alloc] initWithValue:20];
        NSTreeNode *node25 = [[NSTreeNode alloc] initWithValue:25];
        
        node15.left = node10;
        node15.right = node20;
        
        node10.left = node5;
        node5.left = node1;
        node5.right = node7;
        node7.right = node8;
        
        node15.right = node20;
        node20.left = node17;
        node20.right = node25;
        
        NSLog(@"%ld", [node15 inorderSuccessor2:1].value);
        NSLog(@"%ld", [node15 inorderSuccessor2:8].value);
        NSLog(@"%ld", [node15 inorderSuccessor2:15].value);
    }
}
