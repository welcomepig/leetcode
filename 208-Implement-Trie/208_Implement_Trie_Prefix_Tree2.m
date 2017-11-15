#import <Foundation/Foundation.h>

@interface TrieNode : NSObject

@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, assign) BOOL isWord;

@end

@implementation TrieNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dict = [NSMutableDictionary dictionary];
        _isWord = NO;
    }
    return self;
}

@end

@interface Trie : NSObject

@property (nonatomic, strong) TrieNode *root;

- (void)insertString:(NSString*)str;
- (BOOL)searchString:(NSString*)str;
- (BOOL)startsWithString:(NSString*)str;

@end

@implementation Trie

- (instancetype)init
{
    self = [super init];
    if (self) {
        _root = [[TrieNode alloc] init];
    }
    return self;
}

- (void)insertString:(NSString*)str
{
    TrieNode *node = _root;
    for (NSInteger i = 0;i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if (!node.dict[@(c)]) {
            node.dict[@(c)] = [[TrieNode alloc] init];
        }
        node = node.dict[@(c)];
    }
    node.isWord = YES;
}

- (BOOL)searchString:(NSString*)str
{
    TrieNode *node = _root;
    for (NSInteger i = 0;i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if (!node.dict[@(c)]) return NO;
        node = node.dict[@(c)];
    }
    return node.isWord;
}

- (BOOL)startsWithString:(NSString*)str
{
    TrieNode *node = _root;
    for (NSInteger i = 0;i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if (!node.dict[@(c)]) return NO;
        node = node.dict[@(c)];
    }
    return YES;
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Trie *trie = [[Trie alloc] init];
        [trie insertString:@"lintcode"];
        NSLog(@"%d", [trie searchString:@"code"]);
        NSLog(@"%d", [trie startsWithString:@"lint"]);
        NSLog(@"%d", [trie startsWithString:@"linterror"]);
        [trie insertString:@"linterror"];
        NSLog(@"%d", [trie searchString:@"lintcode"]);
        NSLog(@"%d", [trie startsWithString:@"linterror"]);
    }
}
