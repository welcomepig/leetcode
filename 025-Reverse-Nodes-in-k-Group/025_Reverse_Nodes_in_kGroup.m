#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSNode *next;

-(void)insert:(NSInteger)value;
-(NSNode*)reverseInKGroup:(NSInteger)k;
-(NSNode*)reverseInKGroupRecursive:(NSInteger)k;

@end

@implementation NSNode

-(instancetype)initWithValue:(NSInteger)value
{
    self = [super init];
    if (self) {
        _value = value;
        _next = nil;
    }
    return self;
}

-(void)insert:(NSInteger)value
{
    self.next = [[NSNode alloc] initWithValue:value];
}

-(NSNode*)reverseTo:(NSInteger)k
{
    NSInteger count = 0;
    NSNode *prev, *next, *node = self;
    
    while (count < k && node) {
        count++;
        
        next = node.next;
        node.next = prev;
        
        prev = node;
        node = next;
    }
    
    return prev;
}

-(NSNode*)reverseInKGroup:(NSInteger)k
{
    NSInteger count = 0;
    NSNode *head, *node;
    NSNode *gprev, *ghead, *gnext;
    
    node = self;
    while (node) {
        count = 0;
        gnext = node;
        while (count < k && gnext) {
            count++;
            gnext = gnext.next;
        }
        
        if (count < k) {
            head = node;
            gnext = nil;
        } else {
            head = [node reverseTo:k];
        }
        
        if (!ghead) {
            ghead = head;
        }
        gprev.next = head;
        gprev = node;
        node = gnext;
    }
    
    return ghead;
}

-(NSNode*)reverseInKGroupRecursive:(NSInteger)k
{
    NSInteger count = 0;
    NSNode *head, *prev, *node, *next;
    
    head = node = next = self;
    while (count < k && node) {
        count++;
        node = node.next;
    }
    
    if (count == k) {
        prev = [node reverseInKGroupRecursive:k];
        
        while (count > 0) {
            next = head.next;
            head.next = prev;
            
            prev = head;
            head = next;
            
            count--;
        }
        head = prev;
    }
    
    return head;
}

@end

@interface NSList : NSObject

@property (nonatomic, strong) NSNode *root;

-(void)reverseInKGroup:(NSInteger)k;

@end

@implementation NSList

-(instancetype)init
{
    self = [super init];
    if (self) {
        _root = nil;
    }
    return self;
}

-(NSString*)description
{
    NSMutableString *result = [NSMutableString string];
    NSNode *node = self.root;
    while (node) {
        [result appendFormat:@"%ld ", node.value];
        node = node.next;
    }
    return [result copy];
}

-(void)insert:(NSInteger)value
{
    if (!self.root) {
        self.root = [[NSNode alloc] initWithValue:value];
        return;
    }
    
    NSNode *node = self.root;
    while (node.next) {
        node = node.next;
    }
    [node insert:value];
}

-(void)reverseInKGroup:(NSInteger)k
{
    self.root = [self.root reverseInKGroup:k];
}

-(void)reverseInKGroupRecursive:(NSInteger)k
{
    self.root = [self.root reverseInKGroupRecursive:k];
}

@end
 
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSList *list = [[NSList alloc] init];
        [list insert:5];
        [list insert:7];
        [list insert:3];
        [list insert:0];
        [list insert:9];
        [list insert:11];
        [list insert:4];
        NSLog(@"%@", list);
        [list reverseInKGroupRecursive:3];
        NSLog(@"%@", list);
    }
}
