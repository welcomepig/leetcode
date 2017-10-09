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

@interface BSTIterator : NSObject

- (instancetype)initWithRoot:(Node*)root;
- (BOOL)hasNext;
- (NSInteger)next;

@end

@interface BSTIterator ()

@property (nonatomic, strong) NSMutableArray <Node*>*stack;
@property (nonatomic, strong) Node *node;

@end

@implementation BSTIterator : NSObject

- (instancetype)initWithRoot:(Node*)root
{
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        _node = root;
    }
    return self;
}

- (BOOL)hasNext
{
    if (!self.node && self.stack.count == 0) return NO;
    
    while (self.node) {
        [self.stack addObject:self.node];
        self.node = self.node.left;
    }
    
    return YES;
}

- (NSInteger)next
{
    self.node = self.stack.lastObject;
    [self.stack removeLastObject];
    
    NSInteger value = self.node.value;
    self.node = self.node.right;
    
    return value;
}

@end

int main(int argc, char * argv[]) {
    Node *root = [[Node alloc] initWithValue:5];
    root.left = [[Node alloc] initWithValue:3];
    root.left.left = [[Node alloc] initWithValue:2];
    root.left.right = [[Node alloc] initWithValue:4];
    root.right = [[Node alloc] initWithValue:7];
    root.right.left = [[Node alloc] initWithValue:6];
    root.right.right = [[Node alloc] initWithValue:8];
    
    BSTIterator *it = [[BSTIterator alloc] initWithRoot:root];
    while ([it hasNext]) {
        NSLog(@"%ld", [it next]);
    }
}
