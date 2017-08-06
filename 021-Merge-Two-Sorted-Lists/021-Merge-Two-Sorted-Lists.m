#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *next;
@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value;
- (void)insert:(NSInteger)value;
+ (Node *)mergeSortedList:(Node *)list1 list2:(Node *)list2;

@end

@implementation Node

- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

-(NSString*)description
{
    NSMutableString *desc = [NSMutableString string];
    Node *node = self;
    while (node) {
        [desc appendFormat:@"%ld ", node.value];
        node = node.next;
    }
    
    return [desc copy];
}

- (void)insert:(NSInteger)value {
    Node *node = self;
    while (node.next) {
        node = node.next;
    }
    node.next = [[Node alloc] initWithValue:value];
}

+ (Node *)mergeSortedList:(Node *)list1 list2:(Node *)list2 {
    if (!list1) return list2;
    if (!list2) return list1;
    
    Node *root = nil;
    Node *node = nil;
    Node *node1 = list1;
    Node *node2 = list2;
    
    while (true) {
        if (!node1 || !node2) {
            node.next = !node1 ? node2 : node1;
            break;
        }
        
        if (node1.value < node2.value) {
            if (!node) {
                root = node1;
                node = root;
            } else {
                node.next = node1;
                node = node.next;
            }
            node1 = node1.next;
        } else {
            if (!node) {
                root = node2;
                node = root;
            } else {
                node.next = node2;
                node = node.next;
            }
            node2 = node2.next;
        }
    }
    
    return root;
}

@end

int main(int argc, char * argv[]) {
    Node *list1 = [[Node alloc] initWithValue:0];
    Node *list2 = [[Node alloc] initWithValue:9];
    
    [list1 insert:1];
    [list1 insert:2];
    [list1 insert:7];
    
    [list2 insert:10];
    [list2 insert:12];
    [list2 insert:16];
    [list2 insert:18];
    
    NSLog(@"%@", [Node mergeSortedList:list1 list2:list2]);
}
