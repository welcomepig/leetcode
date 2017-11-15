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

- (void)addWord:(NSString*)word;
- (BOOL)searchWord:(NSString*)word;

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

- (void)addWord:(NSString*)word
{
    TrieNode *node = _root;
    for (NSInteger i = 0;i < word.length; i++) {
        char c = [word characterAtIndex:i];
        if (!node.dict[@(c)]) {
            node.dict[@(c)] = [[TrieNode alloc] init];
        }
        node = node.dict[@(c)];
    }
    node.isWord = YES;
}

- (BOOL)searchWord:(NSString*)word
{
    return [Trie searchNode:_root word:word index:0];
}

+ (BOOL)searchNode:(TrieNode*)root word:(NSString*)word index:(NSInteger)index
{
    if (index == word.length) return ![word isEqual:@""];
    
    TrieNode *node = root;
    for (NSInteger i = index;i < word.length; i++) {
        char c = [word characterAtIndex:i];
        if (c == '.') {
            for (TrieNode *n in node.dict.allValues) {
                if ([Trie searchNode:n word:word index:(i+1)]) return YES;
            }
            return NO;
        } else {
            if (!node.dict[@(c)]) return NO;
            node = node.dict[@(c)];
        }
    }
    return node.isWord;
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Trie *trie = [[Trie alloc] init];
        [trie addWord:@"bad"];
        NSLog(@"%d", [trie searchWord:@"b.d"]);
        NSLog(@"%d", [trie searchWord:@"b.c"]);
        
    }
}

