---
title: 'LeetCode2: Add two numbers(两数相加)'
date: 2019-01-09 23:17:44
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode-2: Add two numbers(两数相加)


[LeetCode:https://leetcode-cn.com/problems/add-two-numbers/](https://leetcode.com/problems/add-two-numbers/)

[LeetCodeCn:https://leetcode-cn.com/problems/add-two-numbers/](https://leetcode-cn.com/problems/add-two-numbers/)

## 题目说明
给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

<!-- more -->


## 示例：
输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)

输出：7 -> 0 -> 8

输入：(8 -> 4 -> 9) + (5 -> 6 -> 3)

输出：3 -> 1 -> 3 -> 1

## 解题方法
### 初等数学
简单的数学相加即可,不过需要处理几个特殊情况,当两个链表长度不同时,短链表下一位数据用0填充

在两个链接相加的过程中,增加一个变量,用于记录低位和像高位的进位情况,在两个链表遍历后,在查看此值,决定是否添加高位.

#### 图解相关思路
这里输入的两个链表分别为8->4->9和5->6->3
![输入条件](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-9/42941014.jpg)

同时取出两个钟列表的第一个元素,计算sum =13,因为result只记录当前个位数据,通过sum%10得到个位内容,添加到结果链表尾部,同时计算进位标识carry = sum/10 = 1.
![index=0](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-9/69281328.jpg)

重复上面步骤,将1插入结果链表尾部,计算carry = 1
![index=1](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-10/16599903.jpg)

重复上面步骤,将3插入结果链表尾部,计算carry = 1
![index=2](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-10/65109518.jpg)

当L1和L2都遍历结束后,检查carry的内容,发现此时carry非0,则尾插一个carry作为高位的内容
![补位](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-10/11081499.jpg)


#### 代码实现
```java
public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
    ListNode result = new ListNode(0);
    ListNode temp = result;
    int carry = 0;

    while (l1 != null || l2 != null) {
        int a = (l1 != null) ? l1.val : 0;
        int b = (l2 != null) ? l2.val : 0;
        int sum = carry + a + b;

        carry = sum / 10;
        temp.next = new ListNode(sum % 10);
        temp = temp.next;

        if (l1 != null) l1 = l1.next;
        if (l2 != null) l2 = l2.next;
    }


    if (carry > 0) {
        temp.next = new ListNode(carry);
    }
    return result.next;
}
```


[相关代码](https://github.com/clwater/Code/blob/master/src/AddingTwoLinkNumbers.java)欢迎大家关注并提出改进的建议
