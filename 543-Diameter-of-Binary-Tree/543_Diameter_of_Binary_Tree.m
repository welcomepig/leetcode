#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSInteger)value;
- (NSUInteger)diameter;
- (NSUInteger)depth;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value left:(Node*)left right:(Node*)right
{
    self = [super init];
    if (self) {
        _value = value;
        _left = left;
        _right = right;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value left:nil right:nil];
}

- (NSUInteger)diameter
{
    NSUInteger diameter = 0;
    
    [self depth:&diameter];
    
    return diameter;
}

- (NSUInteger)depth:(NSUInteger*)diameter
{
    if (!self.left && !self.right) return 1;
    
    NSUInteger ld = (self.left) ? [self.left depth:diameter] : 0;
    NSUInteger rd = (self.right) ? [self.right depth:diameter] : 0;
    
    *diameter = MAX(*diameter, ld + rd);
    
    return MAX(ld, rd) + 1;
}

@end

int main(int argc, char * argv[]) {
    Node *node = [[Node alloc] initWithValue:1];
    node.left = [[Node alloc] initWithValue:2];
    node.right = [[Node alloc] initWithValue:3];
    node.left.left = [[Node alloc] initWithValue:4];
    node.left.right = [[Node alloc] initWithValue:5];
    
    NSLog(@"%lu", node.diameter);
}
