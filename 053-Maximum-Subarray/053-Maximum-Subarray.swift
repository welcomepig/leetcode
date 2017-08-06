class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count = 0 {
            return 0
        }
        
        var sum = 0
        var maxSum = nums[0]
        var minSum = 0
        
        for num in nums {
            sum += num
            if sum - minSum > maxSum {
                maxSum = sum
            }
            if sum < minSum {
                minSum = sum
            }
        }
        
        return maxSum
    }
}
