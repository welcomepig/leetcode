#import <Foundation/Foundation.h>

@interface TNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TNode *left;
@property (nonatomic, strong) TNode *right;

- (instancetype)initWithValue:(NSInteger)value;
- (void)insert:(NSInteger)value;
+ (NSString *)serialize:(TNode*)node;
+ (TNode *)deserialize:(NSString*)data;

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

+ (NSString *)serialize:(TNode*)root {
    NSMutableString *result = [NSMutableString string];
    
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:root];
    
    NSUInteger count = queue.count;
    BOOL hasNode = YES;
    
    while (count != 0 && hasNode) {
        hasNode = NO;
        for (NSUInteger i = 0;i < count; i++) {
            if ([queue[i] isKindOfClass:[TNode class]]) {
                TNode *node = queue[i];
                [result appendFormat:@"%ld,", node.value];
                
                if (node.left) {
                    hasNode = YES;
                    [queue addObject:node.left];
                } else {
                    [queue addObject:[NSNull null]];
                }
                
                if (node.right) {
                    hasNode = YES;
                    [queue addObject:node.right];
                } else {
                    [queue addObject:[NSNull null]];
                }
            } else if (queue[i] == [NSNull null]) {
                [result appendString:@"null,"];
            }
        }
        
        [queue removeObjectsInRange:NSMakeRange(0, count)];
        count = queue.count;
    }
    
    // remove last comma
    return [result substringWithRange:NSMakeRange(0, result.length - 1)];
}

+ (TNode *)deserialize:(NSString *)data {
    NSArray *nodes = [data componentsSeparatedByString:@","];
    if (nodes.count == 0) return nil;
    
    NSUInteger i = 0;
    TNode *root = [[TNode alloc] initWithValue:[nodes[i++] integerValue]];
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:root];
    NSUInteger count = queue.count;
    
    while (count != 0) {
        for (NSUInteger j = 0;j < count; j++) {
            TNode *node = queue[j];
            if (i < nodes.count && ![nodes[i] isEqualToString:@"null"]) {
                node.left = [[TNode alloc] initWithValue:[nodes[i] integerValue]];
                [queue addObject:node.left];
            }
            i++;
            if (i < nodes.count && ![nodes[i] isEqualToString:@"null"]) {
                node.right = [[TNode alloc] initWithValue:[nodes[i] integerValue]];
                [queue addObject:node.right];
            }
            i++;
        }
        
        [queue removeObjectsInRange:NSMakeRange(0, count)];
        count = queue.count;
    }
    
    return root;
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
    
    NSString *data = [TNode serialize:node5];
    TNode *root = [TNode deserialize:data];
    NSLog(@"%@ %@", data, root);
}

