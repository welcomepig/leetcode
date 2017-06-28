#import <Foundation/Foundation.h>
#import <stdio.h>

@interface DoubleArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, strong) NSMutableArray *data;

-(void)addRow:(NSArray*)data;
-(BOOL)searchWord:(NSString*)word;

@end

@implementation DoubleArray

-(NSInteger)row
{
    if (self.data) {
        return self.data.count;
    }

    return 0;
}

-(NSInteger)column
{
    if (self.data && self.data.count > 0) {
        return ((NSMutableArray*)self.data[0]).count;
    }

    return 0;
}

-(void)addRow:(NSArray*)data
{
    if (!self.data) {
        self.data = [NSMutableArray array];
    }
    [self.data addObject:[data mutableCopy]];
}

-(BOOL)searchWord:(NSString*)word index:(NSInteger)index posx:(NSInteger)posx posy:(NSInteger)posy used:(NSMutableSet*)used
{
    if (word.length == index) {
        return YES;
    }
    
    [used addObject:@(self.column * posx + posy)];
    
    NSString *prefix = [word substringWithRange:NSMakeRange(index, 1)];
    NSInteger i, j;
    
    j = posy;
    for (i = posx - 1;i <= posx + 1;i = i + 2) {
        if (i < 0 || i >= self.row) {
            continue;
        }
        NSMutableArray *rowData = (NSMutableArray*)self.data[i];
        if ([prefix isEqual:rowData[j]] && 
            ![used containsObject:@(self.column * i  + j)] &&
            [self searchWord:word index:(index + 1) posx:i posy:j used:used]) {
            return YES;
        }
    }
    
    i = posx;
    for (j = posy - 1;j <= posy + 1;j = j + 2) {
        if (j < 0 || j >= self.column) {
            continue;
        }
        NSMutableArray *rowData = (NSMutableArray*)self.data[i];
        if ([prefix isEqual:rowData[j]] &&
            ![used containsObject:@(self.column * i  + j)] &&
            [self searchWord:word index:(index + 1) posx:i posy:j used:used]) {
            return YES;
        }
    }
    
    [used removeObject:@(self.column * posx + posy)];
    return NO;
}

-(BOOL)searchWord:(NSString*)word
{   
    if (word.length == 0) {
        return YES;
    }
    
    NSInteger i, j;
    NSString *prefix = [word substringWithRange:NSMakeRange(0, 1)];
    NSMutableSet *used = [NSMutableSet set];
    
    for (i = 0;i < self.row; i++) {
        NSMutableArray *rowData = (NSMutableArray*)self.data[i];
        for (j = 0;j < self.column; j++) {
            if ([prefix isEqual:rowData[j]] && 
                [self searchWord:word index:1 posx:i posy:j used:used]) {
                return YES;
            }
        }
    }
    
    return NO;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        DoubleArray *data = [[DoubleArray alloc] init];
        [data addRow:@[@"A", @"B", @"C", @"E"]];
        [data addRow:@[@"S", @"F", @"C", @"S"]];
        [data addRow:@[@"A", @"D", @"E", @"E"]];
        NSLog(@"%d", [data searchWord:@"ABCCED"]);
        NSLog(@"%d", [data searchWord:@"SEE"]);
        NSLog(@"%d", [data searchWord:@"ABCB"]);
    }
}

