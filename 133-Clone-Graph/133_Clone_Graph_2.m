#import <Foundation/Foundation.h>

@interface GraphNode : NSObject <NSCopying>

@property (nonatomic, assign) NSInteger label;
@property (nonatomic, strong) NSArray *neighbors;

- (instancetype)initWithLabel:(NSInteger)label neighbors:(NSArray*)neighbors;
- (instancetype)initWithLabel:(NSInteger)label;

@end

@implementation GraphNode

- (instancetype)initWithLabel:(NSInteger)label neighbors:(NSArray*)neighbors
{
    self = [super init];
    if (self) {
        _label = label;
        _neighbors = neighbors;
    }
    return self;
}

- (instancetype)initWithLabel:(NSInteger)label
{
    return [[GraphNode alloc] initWithLabel:label neighbors:nil];
}

/*
#pragma mark - BFS 
 
- (instancetype)copyWithZone:(NSZone *)zone
{
    // 1. cloned self
    NSMutableDictionary<NSNumber*, GraphNode*> *clonedNodes = [NSMutableDictionary dictionary];
    GraphNode *root = [[GraphNode alloc] initWithLabel:self.label];
    clonedNodes[@(self.label)] = root;
    
    // 2. cloned neighbors
    NSMutableArray *nodes = [NSMutableArray array];
    [nodes addObject:self];
    while (nodes.count > 0) {
        NSUInteger c = nodes.count;
        for (NSInteger i = 0;i < c; i++) {
            GraphNode *node = nodes[i];
            NSMutableArray *clonedNeighbors = [NSMutableArray array];
            for (GraphNode *n in node.neighbors) {
                if (!clonedNodes[@(n.label)]) {
                    clonedNodes[@(n.label)] = [[GraphNode alloc] initWithLabel:n.label];
                    [nodes addObject:n];
                }
                [clonedNeighbors addObject:clonedNodes[@(n.label)]];
            }
            clonedNodes[@(node.label)].neighbors = [clonedNeighbors copy];
        }
        [nodes removeObjectsInRange:NSMakeRange(0, c)];
    }
    
    return root;
}
*/

#pragma mark - DFS

- (instancetype)copyWithZone:(NSZone *)zone
{
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    return [self cloneNode:self hash:hash];
}

- (GraphNode*)cloneNode:(GraphNode*)node hash:(NSMutableDictionary*)hash
{
    if (!node) return nil;
    if (hash[@(node.label)]) {
        return hash[@(node.label)];
    }
    
    GraphNode *clonedNode = [[GraphNode alloc] initWithLabel:node.label];
    hash[@(node.label)] = clonedNode;
    NSMutableArray *clonedNeighbors = [NSMutableArray array];
    for (GraphNode *n in node.neighbors) {
        [clonedNeighbors addObject:[self cloneNode:n hash:hash]];
    }
    clonedNode.neighbors = [clonedNeighbors copy];
    
    return clonedNode;
}

@end

int main(int argc, char * argv[]) {
    GraphNode *node2 = [[GraphNode alloc] initWithLabel:2];
    GraphNode *node1 = [[GraphNode alloc] initWithLabel:1];
    GraphNode *node0 = [[GraphNode alloc] initWithLabel:0];
    
    node0.neighbors = @[node1, node2];
    node1.neighbors = @[node0, node2];
    node2.neighbors = @[node0, node1, node2];
    
    GraphNode *clondeNode0 = [node0 copy];
    GraphNode *clondeNode1 = clondeNode0.neighbors[0];
    GraphNode *clondeNode2 = clondeNode0.neighbors[1];
    
    NSLog(@"%@ %@ %@", node0, node1, node2);
    NSLog(@"%@ %@ %@", node0.neighbors, node1.neighbors, node2.neighbors);
    
    NSLog(@"%@ %@ %@", clondeNode0, clondeNode1, clondeNode2);
    NSLog(@"%@ %@ %@", clondeNode0.neighbors, clondeNode1.neighbors, clondeNode2.neighbors);
    
    return 0;
}

