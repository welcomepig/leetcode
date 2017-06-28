#import <Foundation/Foundation.h>
#import <stdio.h>

@interface DLNode : NSObject

@property (nonatomic, assign) NSInteger key;
@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, strong) DLNode *prev;
@property (nonatomic, strong) DLNode *next;

-(instancetype)initWithKey:(NSInteger)key value:(NSUInteger)value;
-(void)insert:(DLNode*)node;

@end

@implementation DLNode

-(instancetype)initWithKey:(NSInteger)key value:(NSUInteger)value
{
    self = [super init];
    if (self) {
        _key = key;
        _value = value;
        _prev = nil;
        _next = nil;
    }
    return self;
}

-(void)insert:(DLNode*)node
{
    node.prev = self;
    node.next = self.next;
    
    self.next.prev = node;
    self.next = node;
}

-(void)remove
{
    self.prev.next = self.next;
    self.next.prev = self.prev;
    self.next = nil;
    self.prev = nil;
}

@end

@interface DLList : NSObject

@property (nonatomic, strong) DLNode *head;
@property (nonatomic, strong) DLNode *tail;

-(void)insertHead:(DLNode*)node;
-(void)moveToHead:(DLNode*)node;
-(void)remove:(DLNode*)node;

@end

@implementation DLList

-(instancetype)init
{
    self = [super init];
    if (self) {
        _head = nil;
        _tail = nil;
    }
    return self;
}

-(void)insertHead:(DLNode*)node
{
    if (!self.tail) {
        self.tail = node;
    }
    
    if (self.head) {
        [node insert:self.head];
    }
    
    self.head = node;
}

-(void)moveToHead:(DLNode*)node
{
    [self remove:node];
    [self insertHead:node];
}

-(void)remove:(DLNode*)node
{
    if ([self.tail isEqual:node]) {
        self.tail = node.prev;
    }
    if ([self.head isEqual:node]) {
        self.head = node.next;
    }
    [node remove];
}

@end

@interface LRUCache : NSObject

@property (nonatomic, assign) NSUInteger capcity;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSMutableDictionary *map;
@property (nonatomic, strong) DLList *list;

-(instancetype)initWithCapacity:(NSUInteger)capacity;
-(NSInteger)get:(NSInteger)key;
-(void)put:(NSInteger)key value:(NSUInteger)value;

@end

@implementation LRUCache

-(instancetype)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self) {
        _capcity = capacity;
        _count = 0;
        _map = [NSMutableDictionary dictionary];
        _list = [[DLList alloc] init];
    }
    return self;
}

-(NSInteger)get:(NSInteger)key
{
    DLNode *node = self.map[@(key)];
    
    if (!node) {
        return -1;
    }
    
    [self.list moveToHead:node];
    
    return node.value;
}

-(void)put:(NSInteger)key value:(NSUInteger)value
{
    DLNode *node = self.map[@(key)];
    
    if (!node) {
        node = [[DLNode alloc] initWithKey:key value:value];
        
        [self.list insertHead:node];
        [self.map setObject:node forKey:@(key)];
        self.count++;
        
        if (self.count > self.capcity) {
            DLNode *tailNode = self.list.tail;
            [self.list remove:tailNode];
            [self.map removeObjectForKey:@(tailNode.key)];
            self.count--;
        }
    } else {
        node.value = value;
        [self.list moveToHead:node];
    }
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        LRUCache *cache = [[LRUCache alloc] initWithCapacity:2];
        [cache put:1 value:1];
        [cache put:2 value:2];
        NSLog(@"%ld", [cache get:1]);   // returns 1
        [cache put:3 value:3];
        NSLog(@"%ld", [cache get:2]);   // returns -1
        [cache put:4 value:4];
        NSLog(@"%ld", [cache get:1]);   // returns -1
        NSLog(@"%ld", [cache get:3]);   // returns 3
        NSLog(@"%ld", [cache get:4]);   // returns 4
    }
}

