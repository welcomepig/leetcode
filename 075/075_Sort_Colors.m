#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (SortColor)

-(void)sortColor;

@end

@implementation NSMutableArray (SortColor)

-(void)sortColor
{
    NSInteger i, j, k;
    NSInteger c[3];
    
    for (i = 0;i < self.count; i++) {
        c[[self[i] integerValue]]++;
    }
    
    k = 0;
    for (i = 0;i < 3; i++) {
        for (j = 0;j < c[i]; j++) {
            self[k] = @(j);
            k++;
        }
    }
}

-(void)sortColor2
{
    NSInteger i, zero = 0, two = self.count - 1;
    
    for (i = 0;i <= two;) {
        if ([self[i] integerValue] == 2) {
            self[i] = self[two];        // i is need to check again
            self[two--] = @(2);
        } else if ([self[i] integerValue] == 0) {
            self[i++] = self[zero];     // i no need to check again, since zero scan before can not be 0 or 2
            self[zero++] = @(0);
        } else {
            i++;
        }
    }
}

@end
 
int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableArray *data1 = [NSMutableArray arrayWithArray:@[@(1), @(0), @(0), @(2), @(1), @(0)]];
        [data1 sortColor2];
        NSLog(@"%@", data1);
    }
}


