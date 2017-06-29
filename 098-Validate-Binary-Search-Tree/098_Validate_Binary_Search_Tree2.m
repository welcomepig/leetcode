#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSNode *left;
@property (nonatomic, strong) NSNode *right;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;
-(BOOL)isValidBST;

@end

@implementation NSNode

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

-(void)insert:(NSInteger)value
{
    if (value < self.value) {
        if (self.left) {
            [self.left insert:value];
        } else {
            self.left = [[NSNode alloc] initWithValue:value];
        }
    } else {
        if (self.right) {
            [self.right insert:value];
        } else {
            self.right = [[NSNode alloc] initWithValue:value];
        }
    }
}

-(BOOL)isValidBST:(NSNumber*)preval
{
    if (self.left && ![self.left isValidBST:preval]) {
        return NO;
    }
    
    if ([preval integerValue] >= self.value) {
        return NO;
    }
    preval = @(self.value);
    
    if (self.right && ![self.right isValidBST:preval]) {
        return NO;
    }
    
    return YES;
}

-(BOOL)isValidBST
{
    NSNumber *preval = @(NSIntegerMin);
    return [self isValidBST:preval];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSNode *tree = [[NSNode alloc] initWithValue:5];
        [tree insert:3];
        [tree insert:2];
        [tree insert:4];
        [tree insert:7];
        [tree insert:6];
        [tree insert:8];
        
        NSNode *tree2 = [[NSNode alloc] initWithValue:5];
        [tree2 insert:3];
        [tree2 insert:2];
        [tree2 insert:4];
        [tree2 insert:7];
        [tree2 insert:6];
        [tree2 insert:8];
        
        NSLog(@"%d", [tree isValidBST]);
    }
}

