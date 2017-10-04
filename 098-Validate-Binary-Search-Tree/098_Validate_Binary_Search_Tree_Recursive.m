@interface TNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) TNode *left;
@property (nonatomic, strong) TNode *right;

- (instancetype)initWithValue:(NSInteger)value;
- (void)insert:(NSInteger)value;
- (BOOL)isValidBST;
+ (BOOL)isValidBST:(TNode*)node;

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

#pragma mark - method (instance)

- (BOOL)isValidBST:(NSNumber*)preValue {
    if (self.left && ![self.left isValidBST:preValue]) {
        return NO;
    }
    if ([preValue integerValue] >= self.value) return NO;
    preValue = @(self.value);
    
    if (self.right && ![self.right isValidBST:preValue]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isValidBST {
    return [self isValidBST:@(NSIntegerMin)];
}

#pragma mark - method (class)

+ (BOOL)isValidBST:(TNode*)node preValue:(NSNumber*)preValue {
    if (!node) return YES;
    if (![TNode isValidBST:node.left preValue:preValue]) return NO;
    if ([preValue integerValue] >= node.value) return NO;
    preValue = @(node.value);
    
    return [TNode isValidBST:node.right preValue:preValue];
}

+ (BOOL)isValidBST:(TNode*)node {
    return [TNode isValidBST:node preValue:@(NSIntegerMin)];
}

@end

int main(int argc, char * argv[]) {
    TNode *tree = [[TNode alloc] initWithValue:5];
    [tree insert:3];
    [tree insert:2];
    [tree insert:4];
    [tree insert:7];
    [tree insert:6];
    [tree insert:8];
    
    NSLog(@"%@ %d", tree, [tree isValidBST]);
}

