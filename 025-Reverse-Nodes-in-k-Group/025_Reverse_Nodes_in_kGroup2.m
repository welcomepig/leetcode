#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *next;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value next:(Node*)next;
- (instancetype)initWithValue:(NSInteger)value;

+ (Node*)reverse:(Node*)head;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value next:(Node*)next
{
    self = [super init];
    if (self) {
        _value = value;
        _next = next;
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value
{
    return [self initWithValue:value next:nil];
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString string];
    Node *node = self;
    
    while (node) {
        [desc appendFormat:@"%ld->", node.value];
        node = node.next;
    }
    [desc appendFormat:@"nil"];
    
    return [desc copy];
}

+ (Node *)reverse:(Node *)head
{
    if (!head || !head.next) return head;
    
    Node *node = head;
    Node *prev = nil;
    Node *next = nil;
    
    while (node) {
        next = node.next;
        node.next = prev;
        
        prev = node;
        node = next;
    }
    
    return prev;
}

+ (Node *)reverseRecursive:(Node *)head byK:(NSUInteger)k
{
    Node *node = head;
    Node *next = nil;
    NSInteger cnt = 0;
    
    while (node && cnt < k) {
        node = node.next;
        cnt++;
    }
    if (cnt == k) {
        node = [Node reverseRecursive:node byK:k];
        while (cnt > 0) {
            next = head.next;
            head.next = node;
            
            node = head;
            head = next;
            
            cnt--;
        }
        head = node;
    }
    
    return head;
}

+ (Node *)reverse:(Node *)n byK:(NSUInteger)k
{
    if (!n || !n.next) return n;
    
    Node *dummy = [[Node alloc] initWithValue:0];
    
    Node *head = n;
    Node *tail = dummy;
    
    Node *node = n;
    Node *prev = nil;
    Node *next = nil;
    NSInteger cnt;
    
    while (node) {
        cnt = 0;
        while (node && cnt < k) {
            node = node.next;       
            cnt++;
        }
        if (cnt == k) {
            cnt = 0;
            node = head;
            prev = nil;
            
            while (node && cnt < k) {
                next = node.next;
                node.next = prev;
                
                prev = node;
                node = next;
                cnt++;
            }
        } else {
            prev = head;
            next = nil;
        }
        
        tail.next = prev;
        tail = head;
        head = next;
        node = head;
    }
    
    return dummy.next;
}

@end

int main(int argc, char * argv[]) {
    Node *node = [[Node alloc] initWithValue:5];
    node.next = [[Node alloc] initWithValue:7];
    node.next.next = [[Node alloc] initWithValue:3];
    node.next.next.next = [[Node alloc] initWithValue:0];
    node.next.next.next.next = [[Node alloc] initWithValue:9];
    node.next.next.next.next.next = [[Node alloc] initWithValue:11];
    node.next.next.next.next.next.next = [[Node alloc] initWithValue:8];
    
    NSLog(@"%@", node);
    NSLog(@"%@", [Node reverseRecursive:node byK:2]);
}
