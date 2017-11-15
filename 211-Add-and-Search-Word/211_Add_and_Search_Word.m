#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTrieNode : NSObject {
    NSTrieNode *nodes[26];
}

@property (nonatomic, strong) NSMutableDictionary *trie;
@property (nonatomic, assign) BOOL isWord;

-(void)insertWord:(NSString*)word;

@end

@implementation NSTrieNode

-(instancetype)init
{
    self = [super init];
    if (self) {
        _trie = [NSMutableDictionary dictionary];
        _isWord = NO;
    }
    return self;
}

-(void)insertWord:(NSString*)word
{
    NSTrieNode *node = self;
    
    for (int i = 0;i < word.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
        
        if (!node.trie[c]) {
            [node.trie setValue:[[NSTrieNode alloc] init] forKey:c];
        }
        node = node.trie[c];
    }
    node.isWord = YES;
}

-(BOOL)searchWord:(NSString*)word
{
    NSTrieNode *node = self;
    
    for (int i = 0;i < word.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
        if ([c isEqualToString:@"."]) {
            int j;
            for (j = 0;j < 26; j++) {
                NSString *k = [NSString stringWithFormat:@"%c", 'a' + j];
                NSTrieNode *subnode = node.trie[k];
                if (subnode && [subnode searchWord:[word substringFromIndex:(i + 1)]]) {
                    return YES;
                }
            }
            if (j == 26) {
                return NO;
            }
        } else if (!node.trie[c]) {
            return NO;
        }
        node = node.trie[c];
    }
    
    return node.isWord;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSTrieNode *root = [[NSTrieNode alloc] init];
        [root insertWord:@"bad"];
        NSLog(@"%d", [root searchWord:@"b.d"]);
    }
}

