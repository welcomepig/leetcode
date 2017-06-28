#import <Foundation/Foundation.h>
#import <stdio.h>

@interface Graph : NSObject

@property (nonatomic, assign) NSInteger n;
@property (nonatomic, strong) NSArray *edges;

-(instancetype)initWithEdges:(NSArray*)edges n:(NSInteger)n;

-(BOOL)isGraphValidTreeUnion;
-(BOOL)isGraphValidDFS;
+(BOOL)hasCycle:(NSMutableDictionary*)adjs visited:(NSMutableSet*)visited cur:(NSInteger)cur parent:(NSInteger)parent;

@end

@implementation Graph

-(instancetype)initWithEdges:(NSArray*)edges n:(NSInteger)n
{
    self = [super init];
    if (self) {
        _edges = edges;
        _n = n;
    }
    
    return self;
}

-(BOOL)isGraphValidDFS
{
    // check no cycles
    NSMutableDictionary *adjs = [NSMutableDictionary dictionary];   
    NSArray *edge;
    
    for (int i = 0;i < self.edges.count; i++) {
        edge = (NSArray*)self.edges[i];
        if (!adjs[edge[0]]) {
            adjs[edge[0]] = [NSMutableArray array];
        }
        if (!adjs[edge[1]]) {
            adjs[edge[1]] = [NSMutableArray array];
        }
        [(NSMutableArray*)adjs[edge[0]] addObject:edge[1]];
        [(NSMutableArray*)adjs[edge[1]] addObject:edge[0]];
    }
    
    NSMutableSet *visited = [NSMutableSet set];
    if ([Graph hasCycle:adjs visited:visited cur:0 parent:-1]) {
        return NO;
    }
    
    // check connected (all visited)
    for (int i = 0;i < self.n; i++) {
        if (![visited containsObject:@(i)]) {
            return NO;
        }
    }
    
    
    return YES;
}

+(BOOL)hasCycle:(NSMutableDictionary*)adjs visited:(NSMutableSet*)visited cur:(NSInteger)cur parent:(NSInteger)parent
{
    if ([visited containsObject:@(cur)]) return YES;
    [visited addObject:@(cur)];
    for (NSObject* node in (NSMutableArray*)adjs[@(cur)]) {
        NSInteger next = [(NSNumber*)node intValue];
        if (parent != next && [Graph hasCycle:adjs visited:visited cur:next parent:cur]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isGraphValidTreeUnion
{
    NSMutableDictionary *roots = [NSMutableDictionary dictionary];   
    NSArray *edge;
    
    for (int i = 0;i < self.edges.count; i++) {
        edge = (NSArray*)self.edges[i];
        NSInteger x = [self find:[(NSNumber*)edge[0] intValue] inRoots:roots];
        NSInteger y = [self find:[(NSNumber*)edge[1] intValue] inRoots:roots];
        if (x == y) return NO;
        roots[@(x)] = @(y);
    }
    
    return (self.edges.count == (self.n - 1));
}

-(NSInteger)find:(NSInteger)node inRoots:(NSMutableDictionary*)roots
{
    if (!roots[@(node)]) return node;
    
    return [(NSNumber*)roots[@(node)] intValue];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        Graph *g1 = [[Graph alloc] initWithEdges:@[@[@(0), @(1)], @[@(0), @(2)], @[@(0), @(3)], @[@(1), @(4)]] n:5];
        NSLog(@"%d", [g1 isGraphValidDFS]);
        
        Graph *g2 = [[Graph alloc] initWithEdges:@[@[@(0), @(1)], @[@(1), @(2)], @[@(2), @(3)], @[@(1), @(3)], @[@(1), @(4)]] n:5];
        NSLog(@"%d", [g2 isGraphValidDFS]);
    }
}

