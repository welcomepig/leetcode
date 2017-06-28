#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(TreeNode*)findKthNode:(NSInteger)k;
-(void)insert:(NSInteger)value;

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

- (void)insert:(NSInteger)value
{
    if (value < self.value) {
        if (self.left) {
            [self.left insert:value];
        } else {
            self.left = [[TreeNode alloc] initWithValue:value];
        }
    } else {
        if (self.right) {
            [self.right insert:value];
        } else {
            self.right = [[TreeNode alloc] initWithValue:value];
        }
    }
}

-(NSInteger)countNode
{
    if (!self.left && !self.right) {
        return 1;
    }
    return 1 + [self.left countNode] + [self.right countNode];
}

-(TreeNode*)findKthNode:(NSInteger)k
{
    NSInteger leftCount = [self.left countNode];
    
    if (k > leftCount + 1) {
        return [self.right findKthNode:(k - leftCount - 1)];
    } else if (k <= leftCount) {
        return [self.left findKthNode:k];
    }
    
    return self;
}

-(TreeNode*)findKthNodeCount:(NSInteger*)count
{
    TreeNode* node = [self.left findKthNodeCount:count];
    if (node) {
        return node;
    }
    (*count)--;
    if (*count == 0) {
        return self;
    }
    node = [self.right findKthNodeCount:count];
    if (node) {
        return node;
    }
    return nil;
}

-(TreeNode*)findKthNode2:(NSInteger)k
{
    return [self findKthNodeCount:&k];
}

-(TreeNode*)findKthNode3:(NSInteger)k
{
    NSMutableArray *stack = [NSMutableArray array];
    NSInteger count = k;
    
    TreeNode *node = self;
    while (stack.count > 0 || node) {
        if (node) {
            [stack addObject:node];
            node = node.left;
        } else {
            node = [stack lastObject];
            count--;
            if (count == 0) {
                return node;
            }
            [stack removeLastObject];
        
            node = node.right;
        }
    }

    return nil;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        TreeNode *root = [[TreeNode alloc] initWithValue:5];
        [root insert:3];
        [root insert:2];
        [root insert:4];
        [root insert:7];
        [root insert:6];
        [root insert:8];
        NSLog(@"%ld", [root findKthNode3:2].value);
    }
}

