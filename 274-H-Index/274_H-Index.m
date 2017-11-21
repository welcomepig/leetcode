#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (HIndex)

-(NSInteger)hindex;
-(NSInteger)hindexHash;

@end

@implementation NSArray (HIndex)

-(NSInteger)hindex
{
    NSInteger index;
    NSSortDescriptor *desc = [[NSSortDescriptor alloc] initWithKey:@"integerValue" ascending:NO];
    NSArray *sorted = [self sortedArrayUsingDescriptors:@[desc]];
    
    for (index = 0;index < sorted.count; index++) {
        if ([sorted[index] integerValue] < index + 1) {
            break;
        }
    }
    
    return index;
}

-(NSInteger)hindexHash
{
    NSInteger i, val, count = 0;
    NSInteger hash[self.count + 1];
    
    for (i = 0;i <= self.count; i++) {
        hash[i] = 0;
    }
    
    for (i = 0;i < self.count; i++) {
        val = [self[i] integerValue];
        if (val > self.count) {
            hash[self.count]++;
        } else {
            hash[val]++;
        }
    }
    
    for (i = self.count;i >= 0; i--) {
        count = count + hash[i];
        if (count >= i) {
            return i;
        }
    }
    
    return 0;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *indexes = @[@(3), @(0), @(6), @(1), @(5)];
        NSLog(@"%ld", [indexes hindex]);
        NSLog(@"%ld", [indexes hindexHash]);
    }
}

