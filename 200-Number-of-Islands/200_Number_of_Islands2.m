#import <Foundation/Foundation.h>

@interface NumberOfIslands : NSObject

+ (NSUInteger)numberOfIslands:(NSInteger **)islands m:(NSUInteger)m n:(NSUInteger)n;

@end

@implementation NumberOfIslands

+ (BOOL)findIslands:(NSInteger **)islands m:(NSUInteger)m n:(NSUInteger)n i:(NSInteger)i j:(NSInteger)j 
{
    if (i < 0 || j < 0 || i >= m || j >= n || islands[i][j] == 0) return NO;
    
    islands[i][j] = 0;
    
    [NumberOfIslands findIslands:islands m:m n:n i:(i-1) j:j];
    [NumberOfIslands findIslands:islands m:m n:n i:(i+1) j:j];
    [NumberOfIslands findIslands:islands m:m n:n i:i j:(j-1)];
    [NumberOfIslands findIslands:islands m:m n:n i:i j:(j+1)];
    
    return YES;
}

+ (NSUInteger)numberOfIslands:(NSInteger **)islands m:(NSUInteger)m n:(NSUInteger)n
{
    NSInteger i, j;
    NSUInteger number = 0;
    
    for (i = 0;i < m; i++) {
        for (j = 0;j < n; j++) {
            if ([NumberOfIslands findIslands:islands m:m n:n i:i j:j]) {
                number++;
            }
        }
    }
    
    return number;
}

@end

int main(int argc, char * argv[]) {
    NSInteger **islands = (NSInteger **)malloc(sizeof(NSInteger *) * 4);
    
    for (int i = 0;i < 4; i++) {
        islands[i] = (NSInteger *)malloc(sizeof(NSInteger) * 5);
    }
    
    islands[0][0] = 1;
    islands[0][1] = 1;
    islands[0][2] = 1;
    islands[0][3] = 1;
    islands[0][4] = 0;
    
    islands[1][0] = 1;
    islands[1][1] = 1;
    islands[1][2] = 0;
    islands[1][3] = 1;
    islands[1][4] = 0;

    islands[2][0] = 1;
    islands[2][1] = 1;
    islands[2][2] = 0;
    islands[2][3] = 0;
    islands[2][4] = 0;
    
    islands[3][0] = 0;
    islands[3][1] = 0;
    islands[3][2] = 0;
    islands[3][3] = 0;
    islands[3][4] = 0;
    
    NSLog(@"%lu", [NumberOfIslands numberOfIslands:islands m:4 n:5]);
    
    NSInteger **islands2 = (NSInteger **)malloc(sizeof(NSInteger *) * 4);
    
    for (int i = 0;i < 4; i++) {
        islands2[i] = (NSInteger *)malloc(sizeof(NSInteger) * 5);
    }
    
    islands2[0][0] = 1;
    islands2[0][1] = 1;
    islands2[0][2] = 0;
    islands2[0][3] = 0;
    islands2[0][4] = 0;
    
    islands2[1][0] = 1;
    islands2[1][1] = 1;
    islands2[1][2] = 0;
    islands2[1][3] = 0;
    islands2[1][4] = 0;
    
    islands2[2][0] = 0;
    islands2[2][1] = 0;
    islands2[2][2] = 1;
    islands2[2][3] = 0;
    islands2[2][4] = 0;
    
    islands2[3][0] = 0;
    islands2[3][1] = 0;
    islands2[3][2] = 0;
    islands2[3][3] = 1;
    islands2[3][4] = 1;
    
    NSLog(@"%lu", [NumberOfIslands numberOfIslands:islands2 m:4 n:5]);
}
