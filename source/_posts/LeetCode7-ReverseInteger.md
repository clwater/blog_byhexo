---
title: 'LeetCode7:ReverseInteger(整数反转)'
date: 2019-01-12 23:47:01
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode7:ReverseInteger(整数反转)

[LeetCode:https://leetcode-cn.com/problems/palindrome-number/](https://leetcode.com/problems/palindrome-number/)

[LeetCodeCn:https://leetcode-cn.com/problems/palindrome-number/](https://leetcode-cn.com/problems/palindrome-number/)

## 题目描述
给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−2^31,  2^31 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。


  <!-- more -->

## 示例
* 示例 1:
  * 输入: 123
  * 输出: 321

* 示例 2:
  * 输入: -123
  * 输出: -321

* 示例 3:
  * 输入: 120
  * 输出: 21

## 解题方法
此题相对来说比较简单,不断从x的最后一位取出数字然后校验当前数字是否合法,最后将最后一位移到结果的首位.

再此我们实现一下数字x = 123的翻转.

我们通过x % 10 = 3 来获取到此时x的最后一位为(index)3, 因为将最后一位取走,x需要通过x /= 10来缩小10倍.

在这里我们要验证一下x是否合法,当x > max/10 (因为x缩小了十倍),或者x = max/10并且 index > 7(因为2^31-1=2147483647最后一位为7,当位数相同时仅当index大于7时才移除),负数的验证相近.

当验证通过后通过result = result * 10 + pop来计算出新的result.

如此重复计算,知道x=0时result就是其反转后的数字

## 代码实现
```java
int reverse(int x) {
    int result = 0;

    while (x != 0) {
        int index = x % 10;
        x /= 10;
        if (result > Integer.MAX_VALUE / 10 || (result == Integer.MAX_VALUE / 10 && index > 7)) {
            return 0;
        } else if (result < Integer.MIN_VALUE / 10 || (x == Integer.MIN_VALUE / 10 && index < -8)) {
            return 0;
        }
        result = result * 10 + index;
    }

    return result;
}
```
[相关代码](https://github.com/clwater/Code/blob/master/src/IntegerInversion.java)欢迎大家关注并提出改进的建议
