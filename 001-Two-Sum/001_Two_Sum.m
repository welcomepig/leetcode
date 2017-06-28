#import <Foundation/Foundation.h>
#import <stdio.h>

@interface NSArray (TwoSum)

- (bool)hasTwoSum:(int)target;
    
@end

    
@implementation NSArray (TwoSum)
    
- (bool)hasTwoSum:(int)target
{
    NSMutableDictionary *hash = [NSMutableDictionary dictionary];
    
    for (NSObject* data in self) {
        if ([data isKindOfClass:[NSNumber class]]) {
            int value = [(NSNumber*)data intValue];
            int value_to_find = target - value;

            if ([hash objectForKey:@(value_to_find)]) {
                return true;
            }
            
            hash[@(value)] = @(true);
        }
    }
    
    return false;
}

- (bool)hasTwoSumNoSpace:(int)target
{
    NSArray *sorted = [self sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"sorted = %@", sorted);
    int i = 0;
    int j = self.count - 1;
    
    while (i < j) {
        if (![self[i] isKindOfClass:[NSNumber class]]) {
            i++;
            continue;
        }
        if (![self[j] isKindOfClass:[NSNumber class]]) {
            j--;
            continue;
        }
        
        int value = [(NSNumber*)self[i] intValue];
        int value_to_find = target - value;
        if (value_to_find == [(NSNumber*)self[j] intValue]) {
            return true;
        }
        i++;
        j--;
    }
    
    return false;
}

-(NSArray*)twoSum:(NSInteger)target
{
    NSInteger i, valueToFind;
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    
    for (i = 0;i < self.count; i++) {
        valueToFind = target - [self[i] integerValue];
        if (map[@(valueToFind)]) {
            return @[map[@(valueToFind)], @(i)];
        }
        [map setValue:@(i) forKey:self[i]];
    }
    
    return nil;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSArray *data = [NSArray arrayWithObjects:@(1), @(-1), @(5), @(4), @(6), nil];
        bool result = [data hasTwoSum:7];
        NSLog(@"result = %d", result);
        
        bool result2 = [data hasTwoSumNoSpace:4];
        NSLog(@"result2 = %d", result2);
    }
}

