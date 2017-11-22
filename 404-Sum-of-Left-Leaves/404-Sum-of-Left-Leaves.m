#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger value;

@end

@implementation Node
@end

NSInteger inorderSumOfLeftLeaves(Node *root, BOOL is_left)
{
    if (!root || (!root.left && !root.right)) return is_left ? root.value : 0;
    
    NSInteger sum = 0;
    if (root.left) {
        sum += inorderSumOfLeftLeaves(root.left, YES);
    }
    if (root.right) {
        sum += inorderSumOfLeftLeaves(root.right, NO);
    }
    return sum;
}

NSInteger sumOfLeftLeaves(Node *root)
{
    return inorderSumOfLeftLeaves(root, NO);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

