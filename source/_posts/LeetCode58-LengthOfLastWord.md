---
title: 'LeetCode58-LengthOfLastWord(最后一个单词的长度)'
date: 2019-02-19 22:36:30
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode58-LengthOfLastWord(最后一个单词的长度)

[LeetCode:https://leetcode-cn.com/length-of-last-word/](https://leetcode.com/length-of-last-word/)

[LeetCodeCn:https://leetcode-cn.com/length-of-last-word/](https://leetcode-cn.com/length-of-last-word/)

## 题目描述
给定一个仅包含大小写字母和空格 ' ' 的字符串，返回其最后一个单词的长度。
如果不存在最后一个单词，请返回 0 。

说明：一个单词是指由字母组成，但不包含任何空格的字符串。


<!-- more -->

## 示例
* 输入: "Hello World"
* 输出: 5

## 思路
很简单的一道题,主要是测试用例中' '引起的各种问题,我们可以通过trim去除首位的' ',然后再通过split截断' ',返回最后一个字符串的长度即可.

## 代码实现
```java
public int lengthOfLastWord(String s) {
    s = s.trim();
    String[] strs = s.split(" ");
    if (strs.length == 0){
        return 0;
    }
    return strs[strs.length - 1].length();
}
```


[相关代码](https://github.com/clwater/Code/blob/master/src/LengthOfLastWord.java)欢迎大家关注并提出改进的建议
