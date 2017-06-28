#import <Foundation/Foundation.h>
#import <stdio.h>

@interface Matrix : NSObject

@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign, readonly) NSInteger column;
@property (nonatomic, strong) NSArray *data;

-(instancetype)initWithData:(NSArray*)data;

@end

@implementation Matrix

- (NSInteger)row
{
    return self.data.count;
}

- (NSInteger)column
{
    if (self.data.count == 0) {
        return 0;
    }
    return ((NSArray*)self.data[0]).count;
}

- (NSInteger)valueAt:(NSInteger)i j:(NSInteger)j
{
    NSArray *row = self.data[i];
    return [(NSNumber*)row[j] integerValue];
}

-(instancetype)initWithData:(NSArray*)data
{
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}

-(Matrix*)multiply:(Matrix*)matrix
{
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0;i < self.row; i++) {
        NSMutableArray *row = [NSMutableArray array];
        for (int j = 0;j < matrix.column; j++) {
            NSInteger sum = 0;
            for (int k = 0;k < matrix.row; k++) {
                sum = sum + [self valueAt:i j:j] * [matrix valueAt:k j:j];
            }
            [row addObject:@(sum)];
        }
        [result addObject:[row copy]];
    }
    
    return [[Matrix alloc] initWithData:[result copy]];
}

-(Matrix*)sparseMultiply:(Matrix*)matrix
{
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0;i < self.row; i++) {
        NSMutableArray *row = [NSMutableArray array];
        for (int j = 0;j < self.column; j++) {
            NSInteger sum = 0;
            NSInteger a = [self valueAt:i j:j];
            if (a != 0) {
                for (int k = 0;k < matrix.column; k++) {
                    NSInteger b = [matrix valueAt:j j:k];
                    if (b != 0) {
                        sum = sum + a * b;
                    }
                }
            }
            [row addObject:[NSNumber numberWithInteger:sum]];
        }
        [result addObject:[row copy]];
    }
    
    return [[Matrix alloc] initWithData:[result copy]];
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        Matrix *A = [[Matrix alloc] initWithData:@[@[@(1), @(0), @(0)], @[@(-1), @(0), @(3)]]];
        Matrix *B = [[Matrix alloc] initWithData:@[@[@(7), @(0), @(0)], @[@(0), @(0), @(0)], @[@(0), @(0), @(1)]]];
        
        [A multiply:B];
        [A sparseMultiply:B];
    }
}
