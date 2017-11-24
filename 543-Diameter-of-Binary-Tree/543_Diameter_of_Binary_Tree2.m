#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSInteger)value;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right
{
    self = [super init];
    if (self) {
        _value = value;
        _left = left;
        _right = right;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value left:nil right:nil];
}

@end

NSUInteger depth(Node *root)
{
    if (!root) return 0;
    return 1 + MAX(depth(root.left), depth(root.right));
}

NSUInteger diameter(Node *root)
{
    if (!root) return 0;
    
    NSUInteger ld = diameter(root.left);
    NSUInteger rd = diameter(root.right);
    NSUInteger d = depth(root.left) + depth(root.right);
    
    return MAX(d, MAX(ld, rd));
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Node *node = [[Node alloc] initWithValue:1];
        node.left = [[Node alloc] initWithValue:2];
        node.right = [[Node alloc] initWithValue:3];
        node.left.left = [[Node alloc] initWithValue:4];
        node.left.right = [[Node alloc] initWithValue:5];
        
        NSLog(@"%lu", diameter(node));
    }
}

