#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;

-(TreeNode*)findCommonAncestor:(NSInteger)a b:(NSInteger)b;

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

-(TreeNode*)findCommonAncestor:(NSInteger)a b:(NSInteger)b
{
    if (self.value == a || self.value == b) {
        return self;
    }
    
    TreeNode *left = [self.left findCommonAncestor:a b:b];
    TreeNode *right = [self.right findCommonAncestor:a b:b];

    if (left && right) {
        return self;
    } else if (left) {
        return left;
    } else if (right) {
        return right;
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
        NSLog(@"%ld", [root findCommonAncestor:2 b:4].value);
    }
}

