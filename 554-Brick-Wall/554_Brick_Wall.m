#import <Foundation/Foundation.h>

NSUInteger leastBricks(NSArray<NSArray*> *wall) {
    NSInteger bricks, maxBricks = 0;
    NSMutableDictionary *lengthCount = [NSMutableDictionary dictionary];

    for (NSUInteger i = 0;i < wall.count; i++) {
        NSInteger length = 0;
        for (NSUInteger j = 0;j < wall[i].count - 1; j++) {
            length += [wall[i][j] integerValue];
            bricks = (!lengthCount[@(length)]) ? 1 : [lengthCount[@(length)] integerValue] + 1;
            lengthCount[@(length)] = @(bricks);
            maxBricks = MAX(maxBricks, bricks);
        }
    }
    
    return wall.count - maxBricks;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%lu", leastBricks(@[
        @[@(1),@(2),@(2),@(1)],
        @[@(3),@(1),@(2)],
        @[@(1),@(3),@(2)],
        @[@(2),@(4)],
        @[@(3),@(1),@(2)],
        @[@(1),@(3),@(1),@(1)]]));
    }
}

