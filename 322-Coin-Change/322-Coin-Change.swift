class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 {
            return 0
        }
        
        var dp = Array(repeating: 0, count: amount + 1)
        for coin in coins {
            if coin < amount + 1 {
                dp[coin] = 1
            }
        }
            
        for i in stride(from: 1, to: amount + 1, by: 1) {
            for coin in coins {
                var res = i - coin
                if res > 0 && dp[res] != 0 {
                    dp[i] = (dp[i] == 0) ? dp[res] + 1: min(dp[i], dp[res] + 1)
                }
            }
        }
        
        return (dp[amount] == 0) ? -1 : dp[amount]
    }
}
