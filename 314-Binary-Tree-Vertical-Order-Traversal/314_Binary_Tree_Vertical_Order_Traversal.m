#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;

@end

@implementation TreeNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
        _left = nil;
        _right = nil;
    }
    return self;
}

-(void)verticalTraversal:(NSInteger)pos map:(NSMutableDictionary*)map
{
    if (map[@(pos)]) {
        [(NSMutableArray*)map[@(pos)] addObject:@(self.value)];
    } else {
        map[@(pos)] = [NSMutableArray arrayWithObject:@(self.value)];
    }
    
    [self.left verticalTraversal:(pos-1) map:map];
    [self.right verticalTraversal:(pos+1) map:map];
}

-(NSArray*)verticalTraversal
{
    NSMutableArray *result = [NSMutableArray array];
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    NSInteger i, len;
    
    [self verticalTraversal:0 map:map];
    
    len = map.count;
    for (i = -len + 1;i < len; i++) {
        if (map[@(i)]) {
            [result addObject:map[@(i)]];
        }
    }
    
    return [result copy];
}

-(NSArray*)verticalTraversalBFS
{
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableArray *columns = [NSMutableArray array];
    
    [queue addObject:self];
    [columns addObject:@(0)];
    
    while (queue.count != 0) {
        TreeNode *node = queue[0];
        int col = [(NSNumber*)columns[0] intValue];
        
        [queue removeObjectAtIndex:0];
        [columns removeObjectAtIndex:0];
        
        if (!hash[@(col)]) {
            [hash setObject:[NSMutableArray array] forKey:@(col)];
        }
        [(NSMutableArray*)hash[@(col)] addObject:@(node.value)];
        
        if (node.left) {
            [queue addObject:node.left];
            [columns addObject:@(col - 1)];
        }
        if (node.right) {
            [queue addObject:node.right];
            [columns addObject:@(col + 1)];
        }
    }
    
    NSMutableArray *result = [NSMutableArray array];
    NSArray *sortedKeys = [[hash allKeys] sortedArrayUsingSelector: @selector(compare:)];
    for (int i = 0;i < sortedKeys.count; i++) {
        [result addObject:[hash[sortedKeys[i]] copy]];
    }
    
    return [result copy];
}


@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        TreeNode *root = [[TreeNode alloc] initWithValue:3];
        root.left = [[TreeNode alloc] initWithValue:9];
        root.right = [[TreeNode alloc] initWithValue:8];
        
        root.left.left = [[TreeNode alloc] initWithValue:4];
        root.left.right = [[TreeNode alloc] initWithValue:0];
        
        root.right.left = [[TreeNode alloc] initWithValue:1];
        root.right.right = [[TreeNode alloc] initWithValue:7];
        
        root.left.right.left = [[TreeNode alloc] initWithValue:5];
        root.left.right.right = [[TreeNode alloc] initWithValue:2];
        
        NSLog(@"%@", [root verticalTraversal]);
    }
}

