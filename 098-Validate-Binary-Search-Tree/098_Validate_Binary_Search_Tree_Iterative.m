#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSInteger)value;
- (BOOL)isBST;

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

- (BOOL)isBST
{
    Node *node = self;
    NSMutableArray *stack = [NSMutableArray array];
    BOOL isFirstNode = YES;
    NSInteger value = NSIntegerMin;

    while (node || stack.count != 0) {
        if (node) {
            [stack addObject:node];
            node = node.left;
        } else {
            node = [stack lastObject];
            if (!isFirstNode && node.value <= value) {
                return NO;
            }
            [stack removeLastObject];
            value = node.value;
            node = node.right;
            isFirstNode = NO;
        }
    }
    
    return YES;
}

@end

int main(int argc, char * argv[]) {
    Node *node = [[Node alloc] initWithValue:5];
    node.left = [[Node alloc] initWithValue:3];
    node.left.left = [[Node alloc] initWithValue:2];
    node.left.right = [[Node alloc] initWithValue:7];

    NSLog(@"%d", [node isBST]);
}
