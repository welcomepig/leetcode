#import <Foundation/Foundation.h>
#import <stdio.h>

/*@interface MatchPattern : NSObject

+ (NSArray*)getWords:(NSAray*)words pattern:(NSstring*)pattern;
    
@end

@implementation MatchPattern

+ (NSArray*)getWords:(NSAray*)words pattern:(NSstring*)pattern
{
    return nil;
}
    
@end*/

@interface NSNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) NSNode *next;

+(NSNode*)mergeSortedList:(NSArray*)lists;

-(instancetype)initWithValue:(NSInteger)value;
-(void)insert:(NSInteger)value;
    
@end

@implementation NSNode

+(NSNode*)mergeSortedList:(NSArray*)lists
{
    if (lists.count == 0) {
        return nil;
    } else if (lists.count == 1) {
        return (NSNode*)lists[0];
    }
    
    NSNode *root, *node;
    NSNode *node1 = (NSNode*)lists[0];
    NSNode *node2 = (NSNode*)lists[1];
    
    while (node1 && node2) {
        if (node1.value < node2.value) {
            if (node) {
                node.next = node1;
                node = node.next;
            } else {
                root = node1;
                node = node1;
            }
            node1 = node1.next;
        } else {
            if (node) {
                node.next = node2;
                node = node.next;
            } else {
                root = node2;
                node = node2;
            }
            node2 = node2.next;
        }
    }
    
    if (node1) {
        if (node) {
            node.next = node1;
        } else {
            root = node1;
            node = node1;
        }
    } else if (node2) {
        if (node) {
            node.next = node2;
        } else {
            root = node2;
            node = node2;
        }
    }

    if (lists.count > 2) {
        NSMutableArray *newLists = [NSMutableArray array];
        [newLists addObject:root];
        for (int i = 0;i < lists.count - 2; i++) {
            [newLists addObject:lists[i + 2]];
        }

        return [NSNode mergeSortedList:newLists];
    }
    
    return root;
}

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
    if (self.next) {
        [self.next insert:value];
    } else {
        self.next = [[NSNode alloc] initWithValue:value];
    }
}

-(NSString*)description
{
    NSMutableString *desc = [NSMutableString string];
    NSNode *node = self;
    while (node) {
        [desc appendFormat:@"%ld ", node.value];
        node = node.next;
    }
    
    return [desc copy];
}

@end

int main (int argc, const char * argv[])
{
    NSNode *list1 = [[NSNode alloc] initWithValue:0];
    NSNode *list2 = [[NSNode alloc] initWithValue:4];
    NSNode *list3 = [[NSNode alloc] initWithValue:5];
    NSNode *list4 = [[NSNode alloc] initWithValue:6];
    
    [list1 insert:1];
    [list1 insert:35];
    [list1 insert:77];
    
    [list2 insert:10];
    [list2 insert:12];
    [list2 insert:16];
    [list2 insert:18];
    
    [list3 insert:30];
    [list3 insert:32];
    [list3 insert:50];
    
    [list4 insert:55];
    [list4 insert:60];
    [list4 insert:65];
    [list4 insert:70];
    
    NSLog(@"%@", list1);
    NSLog(@"%@", list2);
    NSLog(@"%@", list3);
    NSLog(@"%@", list4);
    
    NSNode *result = [NSNode mergeSortedList:@[list1, list2, list3, list4]];
    NSLog(@"%@", result);
    
    return 0;
}
