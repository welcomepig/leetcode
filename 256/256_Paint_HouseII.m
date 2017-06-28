#import <Foundation/Foundation.h>
#import <stdio.h>

@interface PaintHouseII : NSObject

@property (nonatomic, strong) NSArray* costs;
@property (nonatomic, readonly, assign) NSInteger houseNum;
@property (nonatomic, readonly, assign) NSInteger colorNum;

-(instancetype)initWithCosts:(NSArray*)costs;
-(NSInteger)calMinCost;
-(NSInteger)calMinCost2;

@end

@implementation PaintHouseII

-(NSInteger)houseNum
{
    return self.costs.count;
}

-(NSInteger)colorNum
{
    return 3;
}

-(instancetype)initWithCosts:(NSArray*)costs
{
    self = [super init];
    if (self) {
        _costs = costs;
    }
    return self;
}

/* O(nk^2) + O(nk) space, n is house num k is color num */
-(NSInteger)calMinCost
{
    if (self.houseNum == 0) {
        return 0;
    }
    
    int minCosts[self.colorNum];
    NSArray *ic = self.costs[0];
    for (int c = 0;c < self.colorNum; c++) {
        minCosts[c] = [(NSNumber*)ic[c] intValue];
    }

    for (int i = 1;i < self.houseNum; i++) {
        NSArray *curC = self.costs[i];
        int tmpMinCosts[3];
        for (int c = 0;c < self.colorNum; c++) {
            NSInteger min = NSIntegerMax;
            for (int pc = 0;pc < self.colorNum; pc++) {
                NSInteger cost = [(NSNumber*)curC[c] intValue] + minCosts[pc];
                if (pc != c && cost < min) {
                    min = cost;
                }
            }
            tmpMinCosts[c] = min;
        }
        for (int c = 0;c < self.colorNum; c++) {
            minCosts[c] = tmpMinCosts[c];
        }
    }

    NSInteger minCost = NSIntegerMax;
    for (int c = 0;c < self.colorNum; c++) {
        if (minCosts[c] < minCost) minCost = minCosts[c];
    }

    return minCost;
}

/* O(nk) + constant space, n is house num k is color num */
-(NSInteger)calMinCost2
{
    if (self.houseNum == 0) {
        return 0;
    }
    
    NSArray *costs;
    NSInteger min1, min2, prev_min1, prev_min2;
    NSInteger cost, min1_cost, min2_cost, prev_min1_cost, prev_min2_cost; /* index */
    
    min1 = min2 = -1;
    prev_min1_cost = prev_min2_cost = 0;
    min1_cost = min2_cost = NSIntegerMax;
    
    for (int i = 0;i < self.houseNum; i++) {
        min1 = min2 = -1;
        costs = self.costs[i];
        
        for (int j = 0;j < self.colorNum; j++) { 
            if (j != prev_min1) {
                cost = [(NSNumber*)costs[j] intValue] + prev_min1_cost;
            } else {
                cost = [(NSNumber*)costs[j] intValue] + prev_min2_cost;
            }
            
            if (min1 < 0 || cost < min1_cost) {
                min2 = min1; min1 = j;
                min2_cost = min1_cost; min1_cost = cost;
            } else if (min2 < 0 || cost < min2_cost) {
                min2 = j; min2_cost = cost;
            }
        }
        
        prev_min1 = min1, prev_min2 = min2;
        prev_min1_cost = min1_cost, prev_min2_cost = min2_cost;
    }
    
    return min1_cost;
}

@end

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        PaintHouseII *house = [[PaintHouseII alloc] initWithCosts:@[@[@(14), @(2), @(11)], @[@(11), @(14), @(5)], @[@(14), @(3), @(10)]]];
        NSLog(@"%ld", [house calMinCost]);
        NSLog(@"%ld", [house calMinCost2]);
    }
}
