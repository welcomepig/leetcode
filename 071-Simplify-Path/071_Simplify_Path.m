#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSString (SimplifyPath)

-(NSString*)simplifyPath;

@end

@implementation NSString (SimplifyPath)

-(NSString*)simplifyPath
{
    NSMutableArray *result = [NSMutableArray array];
    NSArray *dirs = [self componentsSeparatedByString:@"/"];
    
    for (NSString *dir in dirs) {
        if ([dir isEqualToString:@"."] || [dir isEqualToString:@""]) {
            continue;
        }
        
        if ([dir isEqualToString:@".."] && result.count > 0) {
            [result removeLastObject];
        } else if (![dir isEqualToString:@".."]) {
            [result addObject:dir];
        }
    }
    
    return [NSString stringWithFormat:@"/%@", [result componentsJoinedByString:@"/"]];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSString *path1 = @"/a/./b/../../c/";
        NSLog(@"%@", [path1 simplifyPath]);
        
        NSString *path2 = @"/home/";
        NSLog(@"%@", [path2 simplifyPath]);
    }
}

