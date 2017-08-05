#import <Foundation/Foundation.h>

@interface TNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TNode *left;
@property (nonatomic, strong) TNode *right;

- (instancetype)initWithValue:(NSInteger)value;
- (NSArray *)levelOrderTraversal;
- (NSArray *)levelOrderTraversalDFS;

@end

@implementation TNode

- (NSString*)description {
    /* inorder */
    NSString *ldesc = self.left ? [NSString stringWithFormat:@"%@", self.left] : @"";
    NSString *rdesc = self.right ? [NSString stringWithFormat:@"%@", self.right] : @"";
    return [NSString stringWithFormat:@"%@ %ld %@", ldesc, (long)self.value, rdesc];
}

- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    if (self) {
        _value = value;
        _left = nil;
        _right = nil;
    }
    return self;
}

#pragma mark - BFS
- (NSArray *)levelOrderTraversal {
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:self];
    NSUInteger count = queue.count;
    
    while (count != 0) {
        NSMutableArray *level = [NSMutableArray array];
        for (NSUInteger i = 0;i < count; i++) {
            TNode *node = queue[i];
            [level addObject:@(node.value)];
            
            if (node.left) [queue addObject:node.left];
            if (node.right) [queue addObject:node.right];
        }
        
        [result insertObject:[level copy] atIndex:0];
        [queue removeObjectsInRange:NSMakeRange(0, count)];
        count = queue.count;
    }
    
    return [result copy];
}

#pragma mark - DFS

+ (void)levelOrderTraversalDFS:(TNode *)node level:(NSUInteger)level result:(NSMutableArray *)result {
    if (!node) return;
    
    if (level >= result.count) {
        [result addObject:[NSMutableArray array]];
    }
    
    [TNode levelOrderTraversalDFS:node.left level:(level+1) result:result];
    [TNode levelOrderTraversalDFS:node.right level:(level+1) result:result];
    
    
    [result[result.count - 1 - level] addObject:@(node.value)];
}

- (NSArray *)levelOrderTraversalDFS {
    NSMutableArray *result = [NSMutableArray array];
    [TNode levelOrderTraversalDFS:self level:0 result:result];
    
    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    TNode *node5 = [[TNode alloc] initWithValue:5];
    TNode *node4 = [[TNode alloc] initWithValue:4];
    TNode *node7 = [[TNode alloc] initWithValue:7];
    TNode *node3 = [[TNode alloc] initWithValue:3];
    TNode *node2 = [[TNode alloc] initWithValue:2];
    TNode *node1 = [[TNode alloc] initWithValue:-1];
    TNode *node9 = [[TNode alloc] initWithValue:9];
    
    node5.left = node4;
    node5.right = node7;
    
    node4.left = node3;
    node7.left = node2;
    
    node3.left = node1;
    node2.left = node9;

    NSLog(@"%@", [node5 levelOrderTraversalDFS]);
}

