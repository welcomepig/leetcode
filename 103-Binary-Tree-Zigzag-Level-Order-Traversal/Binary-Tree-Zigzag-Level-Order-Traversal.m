@interface TNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TNode *left;
@property (nonatomic, strong) TNode *right;

- (instancetype)initWithValue:(NSInteger)value;
- (void)insert:(NSInteger)value;
- (NSArray *)zigzagLevelOrderTraversal;

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

- (void)insert:(NSInteger)value {
    if (value < self.value) {
        if (!self.left) {
            self.left = [[TNode alloc] initWithValue:value];
        } else {
            [self.left insert:value];
        }
    } else {
        if (!self.right) {
            self.right = [[TNode alloc] initWithValue:value];
        } else {
            [self.right insert:value];
        }
    }
}

- (NSArray *)zigzagLevelOrderTraversal {
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray<TNode*> *queue = [NSMutableArray array];
    BOOL isReverse = NO;
    
    [queue addObject:self];
    NSUInteger count = queue.count;
    
    while (count != 0) {
        NSMutableArray *nodes = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (NSUInteger i = 0;i < count; i++) {
            [nodes addObject:[NSNull null]];
        }
        
        for (NSUInteger i = 0;i < count; i++) {
            TNode *node = queue[i];
            
            if (isReverse) {
                nodes[count - i - 1] = @(node.value);
            } else {
                nodes[i] = @(node.value);
            }
            
            if (node.left) [queue addObject:node.left];
            if (node.right) [queue addObject:node.right];
        }
        [queue removeObjectsInRange:NSMakeRange(0, count)];
        [result addObject:[nodes copy]];
        
        isReverse = !isReverse;
        count = queue.count;
    }
    
    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    TNode *node3 = [[TNode alloc] initWithValue:3];
    TNode *node9 = [[TNode alloc] initWithValue:9];
    TNode *node20 = [[TNode alloc] initWithValue:20];
    TNode *node15 = [[TNode alloc] initWithValue:15];
    TNode *node7 = [[TNode alloc] initWithValue:7];
    
    node3.left = node9;
    node3.right = node20;
    
    node20.left = node15;
    node20.right = node7;
    
    NSLog(@"%@", [node3 zigzagLevelOrderTraversal]);
}

