---
title: 'LeetCode6: ZigZag Conversion(Z字形变换)'
date: 2019-01-12 01:36:17
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode6: ZigZag Conversion(Z字形变换)

[LeetCode:https://leetcode-cn.com/problems/zigzag-conversion/](https://leetcode.com/problems/zigzag-conversion/)

[LeetCodeCn:https://leetcode-cn.com/problems/zigzag-conversion/](https://leetcode-cn.com/problems/zigzag-conversion/)


## 题目描述
将一个给定字符串根据给定的行数，以从上往下、从左到右进行 Z 字形排列。

比如输入字符串为 "LEETCODEISHIRING" 行数为 3 时，排列如下：

  <!-- more -->

L   C   I   R

E T O E S I I G

E   D   H   N

之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："LCIRETOESIIGEDHN"。

## 示例
* 示例 1:
  * 输入: s = "LEETCODEISHIRING", numRows = 3
  * 输出: "LCIRETOESIIGEDHN"

* 示例 2:
  * 输入: s = "LEETCODEISHIRING", numRows = 4
  * 输出: "LDREOEIIECIHNTSG"

## 解题-归纳法
主要思路是遍历一次字符串,通过归纳得到的关系直接生成每行的内容.

## 图解相关思路
下图是一个长度为23的字符串在行数为5的情况下其元素对应的情况

![输入](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-12/16794605.jpg)

我们可以将其分割为三个部分,setp(分割的步长) = 2 * (numRows - 1),至此我们还可以通过用length(s字符串的长度)/step来得到此时我们分割了几部分

![处理1](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-12/31790302.jpg)

我们针对第一部分继续分割,我们可以看到第一行和最后一行都是只有一个元素,和中间有两个元素的行中,两个元素之和步长.

![处理2](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-12/66594411.jpg)

不过当我们归纳下一组时,我们发现非首位行中两个元素和并不简单的是步长,因为再非首组中,其数据经过step长度的平移,归纳后我们可以发现,非首位行的第二个元素(15)其值等于下一组首位(16)减去当前所在行数(1)

![处理3](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-12/59668982.jpg)

那么最后如何实现就十分明了了,不过记得在里层循环的时候,每次增加的长度为step.在非首尾行中,第二个元素需要验证其是否小于length

![解决](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-12/88759683.jpg)

## 代码实现
```java
public String convert(String s, int numRows) {
      if (numRows == 1){
          return s;
      }
      int length = s.length();
      StringBuffer result = new StringBuffer();
      int step = 2 * (numRows - 1);

      for (int i = 0; i < numRows; i++) {
          for (int j = 0; j + i < length; j += step) {
              result.append(s.charAt(j + i));
              if (i != 0 && i != numRows - 1 && j + step - i < length){
                  result.append(s.charAt(j + step - i ));
              }
          }

      }

      return result.toString();

  }
```

[相关代码](https://github.com/clwater/Code/blob/master/src/ZigzagConversion.java)欢迎大家关注并提出改进的建议
