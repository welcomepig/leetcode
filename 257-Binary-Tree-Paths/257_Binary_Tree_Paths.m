#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger val;

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSInteger)value;
- (NSArray<NSString*>*)pathes;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right
{
    self = [super init];
    if (self) {
        _val = value;
        _left = left;
        _right = right;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value left:nil right:nil];
}

- (void)traverseWithPrefix:(NSString*)prefix result:(NSMutableArray*)result
{
    if (!self.left && !self.right) {
        [result addObject:[NSString stringWithFormat:@"%@%ld", prefix, self.val]];
        return;
    }
    
    [self.left traverseWithPrefix:[NSString stringWithFormat:@"%@%ld->", prefix, self.val] result:result];
    [self.right traverseWithPrefix:[NSString stringWithFormat:@"%@%ld->", prefix, self.val] result:result];
}

- (NSArray<NSString*>*)pathes
{
    NSMutableArray *result = [NSMutableArray array];
    [self traverseWithPrefix:@"" result:result];
    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    Node *node1 = [[Node alloc] initWithValue:1];
    node1.left = [[Node alloc] initWithValue:2];
    node1.right = [[Node alloc] initWithValue:3];
    node1.left.right = [[Node alloc] initWithValue:5];
    NSLog(@"%@", [node1 pathes]);
}
