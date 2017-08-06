/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if (l1 == nil) {
            return l2
        }
        if (l2 == nil) {
            return l1
        }
        
        var root : ListNode? = nil
        var node : ListNode? = nil
        var node1 : ListNode? = l1
        var node2 : ListNode? = l2

        while true {
            if (node1 == nil || node2 == nil) {
                node!.next = (node1 == nil) ? node2 : node1
                break
            }

            if (node1!.val < node2!.val) {
                if (node == nil) {
                    root = node1
                    node = node1
                } else {
                    node!.next = node1
                    node = node!.next
                }
                node1 = node1!.next
            } else {
                if (node == nil) {
                    root = node2
                    node = node2
                } else {
                    node!.next = node2
                    node = node!.next
                }
                node2 = node2!.next
            }
        }

        return root
    }
}
