#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, strong) Node *next;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value left:(Node *)left right:(Node *)right next:(Node *)next;
- (instancetype)initWithValue:(NSInteger)value;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value 
                         left:(Node *)left 
                        right:(Node *)right 
                         next:(Node *)next
{
    self = [super init];
    if (self) {
        _left = left;
        _right = right;
        _next = next;
        _value = value;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value left:nil right:nil next:nil];
}

@end


void connectNext(Node *root)
{
    if (!root) return;
    
    NSMutableArray *nodes = [NSMutableArray array];
    [nodes addObject:root];
    NSUInteger count = nodes.count;
    
    while (count != 0) {
        for (NSInteger i = 0;i < count; i++) {
            Node *node = nodes[i];
            if (i + 1 < count) node.next = nodes[i+1];
            if (node.left) [nodes addObject:node.left];
            if (node.right) [nodes addObject:node.right];
        }
        [nodes removeObjectsInRange:NSMakeRange(0, count)];
        count = nodes.count;
    }
}

void connectNextIterate(Node *root)
{
    while (root) {
        Node *dummy = [Node new];
        Node *node = dummy;
        while (root) {
            if (root.left) {
                node.next = root.left;
                node = node.next;
            }
            if (root.right) {
                node.next = root.right;
                node = node.next;
            }
            root = root.next;
        }
        root = dummy.next;
    }
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
    }
}

