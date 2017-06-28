#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (Sorted)

-(NSString*)sorted;

@end

@implementation NSString (Sorted)

int char_compare(const char* a, const char* b) {
    if(*a < *b) {
        return -1;
    } else if(*a > *b) {
        return 1;
    } else {
        return 0;
    }
}

-(NSString*)sorted
{
    int len = self.length;
    char *cstr = malloc(sizeof(char) * (len + 1));
    
    [self getCString:cstr maxLength:(len + 1) encoding:NSISOLatin1StringEncoding];
    qsort(cstr, len, sizeof(char), char_compare);
    NSString *sorted = [NSString stringWithCString:cstr encoding:NSISOLatin1StringEncoding];
    free(cstr);
    
    return sorted;
}

@end

@interface NSArray (GroupAnagrams)

-(NSArray*)groupAnagrams;

@end

@implementation NSArray (GroupAnagrams)

-(NSArray*)groupAnagrams
{
    NSMutableArray *result = [NSMutableArray array];
    NSInteger i, j, hash[26], hashs[self.count][26];
    BOOL isAlone = YES;
    
    for (NSString *word in self) {
        for (i = 0;i < 26; i++) {
            hash[i] = 0;
        }
        for (i = 0;i < word.length; i++) {
            hash[[word characterAtIndex:i] - 'a']++;
        }
        
        isAlone = YES;
        for (i = 0;i < result.count; i++) {
            for (j = 0;j < 26; j++) {
                if (hash[j] != hashs[i][j]) {
                    break;
                }
            }
            if (j == 26) {
                isAlone = NO;
                [(NSMutableArray*)result[i] addObject:word];
                break;
            }
        }
        
        if (isAlone == YES) {
            for (i = 0;i < 26; i++) {
                hashs[result.count][i] = hash[i];
            }
            [result addObject:[NSMutableArray arrayWithObject:word]];
        }
    }
    
    return [result copy];
}

-(NSArray*)groupAnagramsSorted
{
    NSMutableArray *result = [NSMutableArray array];
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    
    for (NSString *word in self) {
        NSString *sortedKey = [word sorted];
        if (hash[sortedKey]) {
            [(NSMutableArray*)hash[sortedKey] addObject:word];
        } else {
            [hash setObject:[NSMutableArray arrayWithObject:word] forKey:sortedKey];
        }
    }
    
    for (NSMutableArray *array in [hash allValues]) {
        [result addObject:[array copy]];
    }
    
    return [result copy];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = @[@"eat", @"tea", @"tan", @"ate", @"nat", @"bat"];
        NSLog(@"%@", [data groupAnagramsSorted]);
    }
}

