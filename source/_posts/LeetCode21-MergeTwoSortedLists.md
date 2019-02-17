---
title: 'LeetCode21-MergeTwoSortedLists(合并两个有序链表)'
date: 2019-02-16 18:39:59
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode21:MergeTwoSortedLists(合并两个有序链表)

[LeetCode:https://leetcode-cn.com/problems/merge-two-sorted-lists/](https://leetcode.com/problems/merge-two-sorted-lists/)

[LeetCodeCn:https://leetcode-cn.com/problems/merge-two-sorted-lists/](https://leetcode-cn.com/problems/merge-two-sorted-lists/)

## 题目描述
将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

## 示例：
* 输入：1->2->4, 1->3->5->6
* 输出：1->1->2->3->4->5->6

  <!-- more -->

## 解题方法-类归并
此两个链表的合并类似归并排序中将分治后的有序序列合并的过程,简单来说就是在合并的时候比较两个链表首位的的大小,取较小的值放入合并后的链表中,并移动对应的链表.

## 图解相关思路
下面针对1->2->4, 1->3->5->6这两个链表进行合并

我们需要额外创建head和result,head用于存储需要返回的链表收节点,result用于跟随当前插入的数据位置

![数据准备](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216191013.png)

分别取出l1的元素为1,l2的元素为1,此时1<=1,则将l1的对应元素的1放入合并后的链表中

![10](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216191926.png)

除此之外,我们还要移动l1和result指向的位置(下图中用红箭头表示实际移动后的位置,此时合并后的结果中的1与result为同一个节点)

![11](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216192121.png)

继续检查链表元素,此时l1中的元素2>l2中的元素1,则将l2中的元素1放入合并后的链表中

![20](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216192412.png)

继续移动相关链表

![21](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216192608.png)

当我们处理了一定的节点后,可能会出现某个链接(l1)不再有节点,此时直接将另一个链表(l2)的剩下节点插入合并后的节点即可
![30](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216192744.png)

## 相关代码
```java
public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
    ListNode result = new ListNode(0);
    ListNode head = result;
    while (l1 != null && l2 != null){
        if (l1.val <= l2.val){
            result.next = new ListNode(l1.val);
            l1 = l1.next;
        }else {
            result.next =  new ListNode(l2.val);
            l2 = l2.next;
        }
        result = result.next;
    }
    if (l1 == null) result.next = l2;
    if (l2 == null) result.next = l1;
    return head.next;
}
```

[相关代码](https://github.com/clwater/Code/blob/master/src/MergeTwoSortedLists.java)欢迎大家关注并提出改进的建议
