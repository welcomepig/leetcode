#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTreeNode : NSObject

@property (nonatomic, strong) NSTreeNode *left;
@property (nonatomic, strong) NSTreeNode *right;
@property (nonatomic, assign) NSInteger value;

-(instancetype)initWithValue:(NSInteger)value;
-(NSArray*)BFS;

@end

@implementation NSTreeNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

-(NSArray*)BFS
{
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableArray *next_queue = [NSMutableArray array];
    
    [queue addObject:self];
    while (queue.count > 0) {
        NSMutableArray *nodes = [NSMutableArray array];
        for (NSTreeNode *node in queue) {
            [nodes addObject:@(node.value)];
            if (node.left) {
                [next_queue addObject:node.left];
            }
            if (node.right) {
                [next_queue addObject:node.right];
            }
        }
        [result addObject:nodes];
        queue = [next_queue copy];
        [next_queue removeAllObjects];
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSTreeNode *node3 = [[NSTreeNode alloc] initWithValue:3];
        NSTreeNode *node9 = [[NSTreeNode alloc] initWithValue:9];
        NSTreeNode *node20 = [[NSTreeNode alloc] initWithValue:20];
        NSTreeNode *node15 = [[NSTreeNode alloc] initWithValue:15];
        NSTreeNode *node7 = [[NSTreeNode alloc] initWithValue:7];
        
        node3.left = node9;
        node3.right = node20;
        
        node20.left = node15;
        node20.right = node7;
        
        [node3 BFS];
    }
}

