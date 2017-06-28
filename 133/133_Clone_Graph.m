#import <Foundation/Foundation.h>
#import <stdio.h>



@interface GNode : NSObject <NSCopying>

@property (nonatomic, assign) NSInteger label;
@property (nonatomic, strong) NSArray *neighbors;

+(NSMutableSet *)getVisited;
+(NSMutableDictionary *)getMap;
-(instancetype)initWithLabel:(NSInteger)label;
-(instancetype)initWithLabel:(NSInteger)label neighbors:(NSArray *)neighbors;

@end

@implementation GNode

+(NSMutableSet *)getVisited
{
    static NSMutableSet *_visited = nil;
    if (!_visited) {
        _visited = [NSMutableSet set];
    }
    return _visited;
}

+(NSMutableDictionary *)getMap
{
    static NSMutableDictionary *_map = nil;
    if (!_map) {
        _map = [NSMutableDictionary dictionary];
    }
    return _map;
}
    
-(instancetype)initWithLabel:(NSInteger)label
{
    self = [super init];
    if (self) {
        _label = label;
    }
    return self;
}

-(instancetype)initWithLabel:(NSInteger)label neighbors:(NSArray *)neighbors
{
    self = [super init];
    if (self) {
        _label = label;
        _neighbors = neighbors;
    }
    return self;
}

/* BFS */
-(instancetype)copyWithZone:(NSZone *)zone
{
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableSet *visited = [GNode getVisited];
    NSMutableDictionary *map = [GNode getMap];

    [queue addObject:self];
    while (queue.count > 0) {
        // pop from queue
        GNode *node = queue[0];
        [queue removeObjectAtIndex:0];

        // if visited => continue
        if ([visited containsObject:@(node.label)]) {
            continue;
        }

        // add neightbors to queue
        for (NSObject *nnode in node.neighbors) {
            [queue addObject:nnode];
        }

        // clone node and its neighbors
        GNode *node_clone = map[@(node.label)] ? map[@(node.label)] :
                            [[[self class] allocWithZone:zone] initWithLabel:node.label];
        map[@(node.label)] = node_clone;

        NSMutableArray *neighbors_clone = [NSMutableArray array];
        for (GNode *nnode in node.neighbors) {
            GNode *nnode_clone = map[@(nnode.label)] ? map[@(nnode.label)] :
                            [[[self class] allocWithZone:zone] initWithLabel:nnode.label];
            [neighbors_clone addObject:nnode_clone];
            map[@(nnode.label)] = nnode_clone;
        }
        node_clone.neighbors = [neighbors_clone copy];

        // mark visited
        [visited addObject:@(node.label)];
    }

    return map[@(self.label)];
}

/* DFS */
/*-(instancetype)copyWithZone:(NSZone *)zone
{
    NSMutableDictionary *map = [GNode getMap];
    
    if (map[@(self.label)]) {
        return map[@(self.label)];
    }
    
    GNode *node_clone = [[[self class] allocWithZone:zone] initWithLabel:self.label];
    map[@(self.label)] = node_clone;
    
    NSMutableArray *neighbors_clone = [NSMutableArray array];
    for (GNode *nnode in self.neighbors) {
        GNode *nnode_clone = [nnode copy];
        [neighbors_clone addObject:nnode_clone];
    }
    node_clone.neighbors = [neighbors_clone copy];
    
    return map[@(self.label)];
}*/

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        GNode *node2 = [[GNode alloc] initWithLabel:2];
        GNode *node1 = [[GNode alloc] initWithLabel:1];
        GNode *node0 = [[GNode alloc] initWithLabel:0];

        node0.neighbors = @[node1, node2];
        node1.neighbors = @[node0, node2];
        node2.neighbors = @[node0, node1, node2];

        GNode *node0_clone = [node0 copy];
        GNode *node1_clone = node0_clone.neighbors[0];
        GNode *node2_clone = node0_clone.neighbors[1];

        NSLog(@"%@ %@ %@", node0, node1, node2);
        NSLog(@"%@ %@ %@", node0.neighbors, node1.neighbors, node2.neighbors);

        NSLog(@"%@ %@ %@", node0_clone, node1_clone, node2_clone);
        NSLog(@"%@ %@ %@", node0_clone.neighbors, node1_clone.neighbors, node2_clone.neighbors);
    }
}
