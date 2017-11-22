#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value;

@end

@implementation Node

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

@end

void serializePreorderTraverse(Node *root, NSMutableString *data)
{
    if (!root) {
        [data appendString:@",#"];
        return;
    }
    
    [data appendFormat:@",%ld", root.value];
    serializePreorderTraverse(root.left, data);
    serializePreorderTraverse(root.right, data);
}

NSString *serialize(Node *root)
{
    NSMutableString *data = [NSMutableString string];
    serializePreorderTraverse(root, data);
    [data deleteCharactersInRange:NSMakeRange(0,1)];
    return [data copy];
}

Node *deserializePreorderTraverse(NSArray *nodes, NSUInteger *idx)
{
    if (*idx >= nodes.count || [nodes[*idx] isEqual:@"#"]) {
        return nil;
    }
    
    Node *node = [[Node alloc] initWithValue:[nodes[*idx] integerValue]];
    *idx = *idx + 1;
    node.left = deserializePreorderTraverse(nodes, idx);
    *idx = *idx + 1;
    node.right = deserializePreorderTraverse(nodes, idx);
    
    return node;
}

Node *deserialize(NSString *data)
{
    NSUInteger idx = 0;
    NSArray *nodes = [data componentsSeparatedByString:@","];
    return deserializePreorderTraverse(nodes, &idx);
}

# pragma mark - #572

BOOL isSameTree(Node *s, Node *t)
{
    if (!s && !t) return YES;
    if (!s || !t || s.value != t.value) return NO;
    
    return isSameTree(s.left, t.left) && isSameTree(s.right, t.right);
}

BOOL isSubTree(Node *s, Node *t)
{
    if (!t || (!s && !t)) return YES;
    if (!s) return NO;
    
    if (isSameTree(s, t)) return YES;
    
    return isSubTree(s.left, t) || isSubTree(s.right, t);
}

BOOL isSubTreeSerialize(Node *s, Node *t)
{
    if (!t || (!s && !t)) return YES;
    if (!s) return NO;
    
    NSString *sdata = serialize(s);
    NSString *tdata = serialize(t);
    
    return [sdata containsString:tdata];
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Node *s = [[Node alloc] initWithValue:3];
        s.left = [[Node alloc] initWithValue:4];
        s.left.left = [[Node alloc] initWithValue:1];
        s.left.right = [[Node alloc] initWithValue:2];
        s.right = [[Node alloc] initWithValue:5];

        Node *t = [[Node alloc] initWithValue:4];
        t.left = [[Node alloc] initWithValue:1];
        t.right = [[Node alloc] initWithValue:2];

        NSLog(@"%d", isSubTree(s, t));
        NSLog(@"%d", isSubTreeSerialize(s, t));
        
        Node *s2 = [[Node alloc] initWithValue:3];
        s2.left = [[Node alloc] initWithValue:4];
        s2.right = [[Node alloc] initWithValue:5];
        s2.left.left = [[Node alloc] initWithValue:1];
        s2.left.right = [[Node alloc] initWithValue:2];
        s2.left.right.left = [[Node alloc] initWithValue:0];
        
        NSLog(@"%d", isSubTree(s2, t));
        NSLog(@"%d", isSubTreeSerialize(s2, t));
    }
}

