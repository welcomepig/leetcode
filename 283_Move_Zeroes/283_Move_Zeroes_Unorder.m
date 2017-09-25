 #import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSMutableArray (UnorderZero)

-(NSInteger)moveZeros;

@end

@implementation NSMutableArray (UnorderZero)

-(NSInteger)moveZeros
{
    NSInteger i, j;
    i = 0;
    j = self.count - 1;
    
    while (i <= j) {
        if ([self[i] intValue] != 0) {
            i++;
            continue;
        }
        if ([self[j] intValue] == 0) {
            j--;
            continue;
        }
        
        // move non-zero to previous
        self[i] = self[j];
        i++;
        j--;
    }
    
    return self.count - j - 1;
}

@end
    
int main (int argc, const char * argv[])
{
    NSMutableArray *data = [NSMutableArray arrayWithArray:@[@(4),@(3),@(0),@(1),@(2),@(0)]];
    
    NSLog(@"%ld %@", [data moveZeros], data);
    
    NSMutableArray *data2 = [NSMutableArray arrayWithArray:@[@(0),@(0),@(0),@(0),@(0)]];
    
    NSLog(@"%ld %@", [data2 moveZeros], data2);
    
    NSMutableArray *data3 = [NSMutableArray arrayWithArray:@[@(7),@(9),@(1),@(5),@(2)]];
    
    NSLog(@"%ld %@", [data3 moveZeros], data3);
    
    return 0;
}
