#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TwoDimArray : NSObject

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) char **data;

-(instancetype)initWithData:(char **)data row:(NSInteger)row column:(NSInteger)column;

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

-(void)traverseIsland:(NSInteger)i j:(NSInteger)j
{
    if (i < 0 || j < 0 || i >= self.row || j >= self.column || self.data[i][j] != '1') {
        return;
    }
    
    self.data[i][j] = '0';
    [self traverseIsland:(i-1) j:j];
    [self traverseIsland:(i+1) j:j];
    [self traverseIsland:i j:(j-1)];
    [self traverseIsland:i j:(j+1)];
}

-(NSInteger)numberOfIslands
{
    NSInteger i, j, num;
    
    num = 0;
    for (i = 0;i < self.row; i++) {
        for (j = 0;j < self.column; j++) {
            if (self.data[i][j] == '1') {
                [self traverseIsland:i j:j];
                num++;
            }
        }
    }
    
    return num;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSInteger i, row = 4, column = 5;
        
        char **board = (char **)malloc(sizeof(char *) * row);
        for (i = 0;i < row; i++) {
            board[i] = (char *)malloc(sizeof(char) * column);
        }
        
        board[0][0] = '1';
        board[0][1] = '1';
        board[0][2] = '0';
        board[0][3] = '0';
        board[0][4] = '0';
        
        board[1][0] = '1';
        board[1][1] = '1';
        board[1][2] = '0';
        board[1][3] = '0';
        board[1][4] = '0';
        
        board[2][0] = '0';
        board[2][1] = '0';
        board[2][2] = '1';
        board[2][3] = '0';
        board[2][4] = '0';
        
        board[3][0] = '0';
        board[3][1] = '0';
        board[3][2] = '0';
        board[3][3] = '1';
        board[3][4] = '1';
        
        TwoDimArray *array = [[TwoDimArray alloc] initWithData:board row:row column:column];
        NSLog(@"%ld", [array numberOfIslands]);
    }
}

