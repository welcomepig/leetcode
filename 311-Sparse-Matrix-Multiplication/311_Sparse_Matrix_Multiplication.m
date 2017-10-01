#import <Foundation/Foundation.h>

@interface Matrix : NSObject

- (NSInteger **)multiply:(NSInteger **)A ma:(NSUInteger)ma na:(NSUInteger)na 
                       B:(NSInteger **)B mb:(NSUInteger)mb nb:(NSUInteger)nb;

@end

@implementation Matrix

- (NSInteger **)multiply:(NSInteger **)A ma:(NSUInteger)ma na:(NSUInteger)na 
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
}
