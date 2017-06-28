#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTreeNode : NSObject

@property (nonatomic, strong) NSTreeNode* left;
@property (nonatomic, strong) NSTreeNode* right;
@property (nonatomic, assign) NSInteger value;

-(instancetype)initWithValue:(NSInteger)value;
-(NSInteger)sumOfLeftLeaves;

@end

@implementation NSTreeNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _left = nil;
        _right = nil;
        _value = value;
    }
    return self;
}

-(NSInteger)sumOfLeftLeaves
{
    return (self.left.value + [self.left sumOfLeftLeaves] + [self.right sumOfLeftLeaves]);
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
        
        NSLog(@"%ld", [node3 sumOfLeftLeaves]);
    }
}

