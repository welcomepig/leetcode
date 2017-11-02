NSUInteger maxProfit(NSUInteger *prices, NSUInteger n) {
    if (n < 2) return 0;
    
    NSUInteger min = prices[0];
    NSUInteger max = 0;
    
    for (int i = 1;i < n; i++) {
        max = MAX(prices[i] - min, max);
        min = MIN(prices[i], min);
    }
    
    return max;
}
