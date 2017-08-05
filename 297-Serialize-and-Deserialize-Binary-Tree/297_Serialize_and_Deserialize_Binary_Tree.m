#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;

+(TreeNode*)deserialize:(NSString*)data;
-(NSString*)serialize;

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

-(NSString*)serialize
{
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"%ld,", self.value];
    if (self.left) {
        [string appendString:[self.left serialize]];
    } else {
        [string appendString:@"X,"];
    }
    if (self.right) {
        [string appendString:[self.right serialize]];
    } else {
        [string appendString:@"X,"];
    }
    
    return [string copy];
}

+ (NSString *)serialize:(TreeNode*)root {
    if (!root) return @"X";

    return [NSString stringWithFormat:@"%ld,%@,%@",
            root.value, [TreeNode serialize:root.left], [TreeNode serialize:root.right]];
}

+(TreeNode*)deserializeWithNodes:(NSMutableArray*)nodes
{
    if (nodes.count == 0) {
        return nil;
    }
    if ([nodes[0] isEqual:@"X"]) {
        [nodes removeObjectAtIndex:0];
        return nil;
    }
    TreeNode *root = [[TreeNode alloc] initWithValue:[nodes[0] integerValue]];
    [nodes removeObjectAtIndex:0];
    
    root.left = [TreeNode deserializeWithNodes:nodes];
    root.right = [TreeNode deserializeWithNodes:nodes];
    
    return root;
}

+(TreeNode*)deserialize:(NSString*)data
{
    NSMutableArray *nodes = [[data componentsSeparatedByString:@","] mutableCopy];
    [nodes removeLastObject];
    return [TreeNode deserializeWithNodes:nodes];
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
        NSString *sdata = [root serialize];
        NSLog(@"%@", sdata);
        TreeNode *croot = [TreeNode deserialize:sdata];
        NSLog(@"%@", croot);
    }
}

