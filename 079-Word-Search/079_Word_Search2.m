#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) char **data;

-(instancetype)initWithData:(char **)data row:(NSInteger)row column:(NSInteger)column;
-(BOOL)isWordSearch:(NSString*)word;

@end

@implementation TwoDimArray

-(instancetype)initWithData:(char **)data row:(NSInteger)row column:(NSInteger)column
{
    self = [super init];
    if (self) {
        _data = data;
        _row = row;
        _column = column;
    }
    return self;
}

-(BOOL)isWordExist:(NSString*)word pos:(NSInteger)pos i:(NSInteger)i j:(NSInteger)j
{
    if (i < 0 || j < 0 || i >= self.row || j >= self.column ||
        self.data[i][j] != [word characterAtIndex:pos]) {
        return NO;
    }
    if (self.data[i][j] == [word characterAtIndex:pos] && pos == word.length - 1) {
        return YES;
    }
    
    char tmp = self.data[i][j];
    self.data[i][j] = ' ';
    
    BOOL isExist = [self isWordExist:word pos:(pos+1) i:(i-1) j:j] ||
                   [self isWordExist:word pos:(pos+1) i:(i+1) j:j] ||
                   [self isWordExist:word pos:(pos+1) i:i j:(j-1)] ||
                   [self isWordExist:word pos:(pos+1) i:i j:(j+1)];
    self.data[i][j] = tmp;
    
    return isExist;
}

-(BOOL)isWordSearch:(NSString*)word
{
    NSInteger i, j;
    
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if ([self isWordExist:word pos:0 i:i j:j]) {
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
        NSInteger i, row = 3, column = 4;
        
        char **board = (char **)malloc(sizeof(char *) * row);
        for (i = 0;i < row; i++) {
            board[i] = (char *)malloc(sizeof(char) * column);
        }
        
        board[0][0] = 'A';
        board[0][1] = 'B';
        board[0][2] = 'C';
        board[0][3] = 'E';
        
        board[1][0] = 'S';
        board[1][1] = 'F';
        board[1][2] = 'C';
        board[1][3] = 'S';
        
        board[2][0] = 'A';
        board[2][1] = 'D';
        board[2][2] = 'E';
        board[2][3] = 'E';
        
        TwoDimArray *array = [[TwoDimArray alloc] initWithData:board row:row column:column];
        NSLog(@"%d", [array isWordSearch:@"ABCCED"]);
        NSLog(@"%d", [array isWordSearch:@"SEE"]);
        NSLog(@"%d", [array isWordSearch:@"ABCB"]);
    }
}

