#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@property (nonatomic, strong) NSNumber *value;

- (instancetype)initWithValue:(NSNumber*)value left:(Node*)left right:(Node*)right;
- (instancetype)initWithValue:(NSNumber*)value;
- (NSArray *)verticalTraversal;

@end

@implementation Node

- (instancetype)initWithValue:(NSNumber*)value left:(Node*)left right:(Node*)right
{
    self = [super init];
    if (self) {
        _value = value;
        _left = left;
        _right = right;
    }
    return self;
}

- (instancetype)initWithValue:(NSNumber*)value
{
    return [self initWithValue:value left:nil right:nil];
}

- (void)verticalTraversal:(NSMutableDictionary<NSNumber*, NSMutableArray*>*)columns idx:(NSInteger)idx
{
    if (!columns[@(idx)]) {
        columns[@(idx)] = [NSMutableArray array];
    }
    [columns[@(idx)] addObject:self.value];
    
    [self.left verticalTraversal:columns idx:(idx-1)];
    [self.right verticalTraversal:columns idx:(idx+1)];
}

- (NSArray *)verticalTraversal
{
    NSMutableArray *result = [NSMutableArray array];
    NSMutableDictionary<NSNumber*, NSMutableArray*> *columns = [NSMutableDictionary dictionary];
    [self verticalTraversal:columns idx:0];
    
    NSArray<NSNumber*>* sortedKeys = [columns.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSNumber *key in sortedKeys) {
        [result addObject:[columns[key] copy]];
    }

    return [result copy];
}

@end

int main(int argc, char * argv[]) {
    Node *root = [[Node alloc] initWithValue:@(3)];
    root.left = [[Node alloc] initWithValue:@(9)];
    root.right = [[Node alloc] initWithValue:@(8)];
    
    root.left.left = [[Node alloc] initWithValue:@(4)];
    root.left.right = [[Node alloc] initWithValue:@(0)];
    
    root.right.left = [[Node alloc] initWithValue:@(1)];
    root.right.right = [[Node alloc] initWithValue:@(7)];
    
    root.left.right.left = [[Node alloc] initWithValue:@(5)];
    root.left.right.right = [[Node alloc] initWithValue:@(2)];
    
    NSLog(@"%@", [root verticalTraversal]);
}
