#import <Foundation/Foundation.h>

@interface Matrix : NSObject

+ (NSInteger **)multiply:(NSInteger **)A ma:(NSUInteger)ma na:(NSUInteger)na 
                       B:(NSInteger **)B mb:(NSUInteger)mb nb:(NSUInteger)nb;

@end

@implementation Matrix

+ (NSInteger **)multiply:(NSInteger **)A ma:(NSUInteger)ma na:(NSUInteger)na 
                       B:(NSInteger **)B mb:(NSUInteger)mb nb:(NSUInteger)nb {
    if (na != mb) return nil;
    
    NSInteger **C = (NSInteger **)malloc(sizeof(NSInteger *) * ma);
    for (int i = 0;i < ma; i++) {
        C[i] = (NSInteger *)malloc(sizeof(NSInteger) * nb);
    }
    
    for (int i = 0;i < ma; i++) {
        for (int j = 0;j < nb; j++) {
            C[i][j] = 0;
        }
    }
    
    for (int i = 0;i < ma; i++) {
        for (int j = 0;j < na; j++) {
            if (A[i][j] == 0) continue;
            for (int k = 0;k < nb; k++) {
                if (B[j][k] == 0) continue;
                C[i][k] += A[i][j] * B[j][k];
            }
        }
    }
    
    return C;
}

@end

int main(int argc, char * argv[]) {
    NSUInteger ma = 2;
    NSUInteger na = 3;
    NSUInteger mb = 3;
    NSUInteger nb = 3;
    
    NSInteger **A = (NSInteger **)malloc(sizeof(NSInteger *) * ma);
    
    for (int i = 0;i < ma; i++) {
        A[i] = (NSInteger *)malloc(sizeof(NSInteger) * na);
    }
    
    A[0][0] = 1;
    A[0][1] = 0;
    A[0][2] = 0;
    
    A[1][0] = -1;
    A[1][1] = 0;
    A[1][2] = 3;
    
    NSInteger **B = (NSInteger **)malloc(sizeof(NSInteger *) * mb);
    
    for (int i = 0;i < mb; i++) {
        B[i] = (NSInteger *)malloc(sizeof(NSInteger) * nb);
    }
    
    B[0][0] = 7;
    B[0][1] = 0;
    B[0][2] = 0;
    
    B[1][0] = 0;
    B[1][1] = 0;
    B[1][2] = 0;
    
    B[2][0] = 0;
    B[2][1] = 0;
    B[2][2] = 1;
    
    NSInteger **C = [Matrix multiply:A ma:ma na:na B:B mb:mb nb:nb];
    
    for (int i = 0;i < ma; i++) {
        for (int j = 0;j < nb; j++) {
            NSLog(@"%ld ", C[i][j]);
        }
        NSLog(@"\n");
    }
}
