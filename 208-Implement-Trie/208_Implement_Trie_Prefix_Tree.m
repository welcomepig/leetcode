#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSTrieNode : NSObject

@property (nonatomic, strong) NSMutableDictionary *next;
@property (nonatomic, assign) BOOL isWord;

-(NSTrieNode*)insert:(char)character isword:(BOOL)isword;

@end
    
@implementation NSTrieNode

    
-(instancetype)init
{
    self = [super init];
    if (self) {
        _next = [NSMutableDictionary dictionary];
        _isWord = NO;
    }
    return self;
}

-(NSTrieNode*)insert:(char)character isword:(BOOL)isword
{
    if (!self.next[@(character)]) {
        self.next[@(character)] = [[NSTrieNode alloc] init];
    }
    ((NSTrieNode*)self.next[@(character)]).isWord = isword;
    
    return self.next[@(character)];
}

@end

@interface NSTrieTree : NSObject

@property (nonatomic, strong) NSTrieNode *root;

-(void)insert:(NSString*)word;
-(BOOL)search:(NSString*)word;
-(BOOL)startBegin:(NSString*)prefix;

@end
    
@implementation NSTrieTree
    
-(instancetype)init
{
    self = [super init];
    if (self) {
        _root = [[NSTrieNode alloc] init];
    }
    return self;
}

-(void)insert:(NSString*)word
{
    NSTrieNode *node = self.root;
    for (int i = 0;i < word.length; i++) {
        char c = [word characterAtIndex:i];
        BOOL isword = (i == word.length - 1);
        node = [node insert:c isword:isword];
    }
}

-(BOOL)search:(NSString*)word
{
    NSTrieNode *node = self.root;
    for (int i = 0;i < word.length; i++) {
        char c = [word characterAtIndex:i];

        if (!node.next[@(c)]) {
            return NO;
        }
        
        node = node.next[@(c)];
    }
    
    return node.isWord;
}

-(BOOL)startBegin:(NSString*)prefix
{
    NSTrieNode *node = self.root;
    for (int i = 0;i < prefix.length; i++) {
        char c = [prefix characterAtIndex:i];

        if (!node.next[@(c)]) {
            return NO;
        }
        
        node = node.next[@(c)];
    }
    
    return YES;
}

@end
    
@interface NSMutableDictionary (Trie)

- (void)insert:(NSString*)word;
- (BOOL)search:(NSString*)word;
- (BOOL)startBegin:(NSString*)prefix;

@end

@implementation NSMutableDictionary (Trie)

- (void)insert:(NSString*)word
{
    if (word.length == 0) {
        [self setObject:@"" forKey:@""];
    }
    
    NSString *key = [word substringWithRange:NSMakeRange(0, 1)];
    if (!self[key]) {
        self[key] = [NSMutableArray array];
    }
    [(NSMutableSet*)self[key] addObject:word];
}

- (BOOL)search:(NSString*)word
{
    if (word.length == 0) {
        return !(!self[@""]);
    }
    
    NSString *key = [word substringWithRange:NSMakeRange(0, 1)];
    if (!self[key]) {
        return NO;
    }
    
    NSMutableSet *set = (NSMutableSet*)self[key];
    return [set containsObject:word];
}

- (BOOL)startBegin:(NSString*)prefix
{
    if (prefix.length == 0) {
        return !(!self[@""]);
    }
    
    NSString *key = [prefix substringWithRange:NSMakeRange(0, 1)];
    if (!self[key]) {
        return NO;
    }
    
    for (NSObject *word in self[key]) {
        if ([(NSString*)word hasPrefix:prefix]) {
            return YES;
        }
    }
    
    return NO;
}
    
@end
    
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data insert:@"lintcode"];
        NSLog(@"%d", [data search:@"code"]);
        NSLog(@"%d", [data startBegin:@"lint"]);
        NSLog(@"%d", [data startBegin:@"linterror"]);
        [data insert:@"linterror"];
        NSLog(@"%d", [data search:@"lintcode"]);
        NSLog(@"%d", [data startBegin:@"linterror"]);
        
        NSLog(@"------- Prefix Tree -------");
        NSTrieTree *tree = [[NSTrieTree alloc] init];
        [tree insert:@"lintcode"];
        NSLog(@"%d", [tree search:@"code"]);
        NSLog(@"%d", [tree startBegin:@"lint"]);
        NSLog(@"%d", [tree startBegin:@"linterror"]);
        [tree insert:@"linterror"];
        NSLog(@"%d", [tree search:@"lintcode"]);
        NSLog(@"%d", [tree startBegin:@"linterror"]);
    }
}

