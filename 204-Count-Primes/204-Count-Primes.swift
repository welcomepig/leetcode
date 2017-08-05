class Solution {    
    func countPrimes(_ n: Int) -> Int {
        var isPrime = Array(repeating: true, count: n + 1)
        var count = 0
        
        for num in stride(from: 2, to: n, by: 1) {
            if isPrime[num] {
                count += 1
                
                var i = 2
                var composite = i * num
                while composite < n {
                    isPrime[composite] = false
                    
                    i += 1
                    composite = i * num
                }
            }
        }
        
        return count
    }
}
