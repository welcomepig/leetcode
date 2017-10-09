#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (MoveZero)

-(NSUInteger)moveZero;

@end

@implementation NSMutableArray (MoveZero)

-(NSUInteger)moveZero
{
    // i point to zero; j point to non-zero
    NSUInteger i = 0, j = 0;
    
    while (j < self.count) {
        if ([self[j] integerValue] == 0) {
            j++;
            continue;
        }
        
        id tmp = self[i];
        self[i] = self[j];
        self[j] = tmp;
        i++; j++;
    }
    
    return (self.count - i)
}

-(NSUInteger)moveZero2
{
    NSUInteger i = 0, j = 0;
    
    for (j = 0;j < self.count; j++) {
        if ([self[j] integerValue] != 0) {
            id tmp = self[i];
            self[i] = self[j];
            self[j] = tmp;
            i++;
        }
    }
    
    return (self.count - i)
}

-(NSUInteger)moveZero3
{
    NSUInteger i = 0, j = 0;
    
    for (j = 0;j < self.count; j++) {
        if ([self[j] integerValue] != 0) {
            self[i] = self[j];
            i++;
        }
    }
    
    for (j = i;j < self.count; j++) {
        self[j] = @(0);
    }
    
    return (self.count - i)
}

-(NSUInteger)moveZeroUnorder
{
    NSInteger i = 0, j = self.count - 1;
    
    while (i < j) {
        if ([self[i] integerValue] != 0) {
            i++;
            continue;
        }
        if ([self[j] integerValue] == 0) {
            j--;
            continue;
        }
        self[i] = self[j];
        self[j] = @(0);
        i++; j--;
    }
    
    return ((self.count - j - 1);
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        
    }
}

