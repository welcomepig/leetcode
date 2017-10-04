#import <Foundation/Foundation.h>

typedef void (^NodeValueHandler)(NSInteger);

@interface Node : NSObject

@property (nonatomic, assign, readonly) NSInteger val;
@property (nonatomic, strong, readonly) Node *left;
@property (nonatomic, strong, readonly) Node *right;

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSInteger)value;
- (void)traverseInorder;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right
{
    self = [super init];
    if (self) {
        _val = value;
        _left = left;
        _right = right;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value left:nil right:nil];
}

- (void)traverseInorder
{
    [self.left traverseInorder];
    NSLog(@"%ld", self.val);
    [self.right traverseInorder];
}

- (void)traverseInorderIterative
{
    NSMutableArray *stack = [NSMutableArray array];
    Node *node = self;
    BOOL isDone = NO;
    
    while (!isDone) {
        if (node) {
            [stack addObject:node];
            node = node.left;
        } else if (stack.count > 0) {
            node = [stack lastObject];
            NSLog(@"%ld", node.val);
            [stack removeLastObject];
            node = node.right;
        } else {
            isDone = YES;
        }
    }
}

- (void)traverseInorder:(NodeValueHandler)handler
{
    if (!handler) return;
    
    [self.left traverseInorder];
    handler(self.val);
    [self.right traverseInorder];
}

- (void)traverseInorderIterative:(void (^)(NSInteger))handler
{
    if (!handler) return;
    
    NSMutableArray *stack = [NSMutableArray array];
    Node *node = self;
    BOOL isDone = NO;
    
    while (!isDone) {
        if (node) {
            [stack addObject:node];
            node = node.left;
        } else if (stack.count > 0) {
            node = [stack lastObject];
            handler(node.val);
            [stack removeLastObject];
            node = node.right;
        } else {
            isDone = YES;
        }
    }
}

@end

int main(int argc, char * argv[]) {
    Node *node3 = [[Node alloc] initWithValue:3];
    Node *node7 = [[Node alloc] initWithValue:7];
    Node *node5 = [[Node alloc] initWithValue:5 left:node3 right:node7];

    [node5 traverseInorder:^(NSInteger value){
        NSLog(@"%ld", value);
    }];
    
    void(^handler)(NSInteger) = ^(NSInteger value){
        NSLog(@"%ld", value);
    };
    
    NSLog(@"-------");
    [node5 traverseInorderIterative:handler];
}
