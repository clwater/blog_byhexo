---
title: 'LeetCode 1: Two sum(两数之和)'
date: 2019-01-08 22:52:01
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode-1: Two sum(两数之和)

> 日常新坑,沉迷学习,无法自拔

> 自己实现的代码,在可解读的前提下尽力优化.

[LeetCode:https://leetcode.com/problems/two-sum/](https://leetcode.com/problems/two-sum/)

[LeetCodeCn:https://leetcode-cn.com/problems/two-sum/submissions/](https://leetcode-cn.com/problems/two-sum/submissions/)

## 题目说明
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

<!-- more -->

## 示例
给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]

## 解题方法
### 暴力枚举
遍历nums中的每个元素x,查找是否存在target-x的元素

### 哈希表辅助(一次遍历)
简单来说就是在遍历的时候将遍历过的x存入HashMap中,已x的值为key,x所在的位置为vaue.在遍历新的元素的时候检查target-x所对应的元素是否包含在HashMap中,如果存在的话就能直接获取到当前x的位置和target-x的位置.

#### 图解相关思路
以下是个测试用例,现在[1,2,7,11,15]的数组中寻找其中哪两个元素和为9.

![输入条件](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-8/15229509.jpg)

根据思路,我们开始遍历此数组

当x = 0时候, 目标target - x = 8, 我们在check中查找是否存在key为8的元素. 此时我们发现没有key为8的元素,将key = 1,value = 0存入check的HashMap中.

![i=0](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-8/30637830.jpg)

移到下一个元素, x = 2,弥补target - x = 7, 在check中也没有找到key为7的元素,和上一步一样,将key = 2, value = 1存入check中.

![i=1](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-8/55085311.jpg)

移到下一个元素, x = 7, 目标target - x = 2,在check中找到了key为2的数据,此时当前 x = 7的位置为2,check中key为2对应的value为1, 也就是说次数组第1项目和第2项所对应的值之和为target

![i=2](http://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/19-1-8/33350674.jpg)

#### 代码实现
```java
public int[] twoSum(int[] nums, int target) {
    HashMap<Integer, Integer> check = new HashMap<>();
    int[] position = new int[2];
    for (int i = 0; i < nums.length; i++) {
        int index = target - nums[i];
        if (check.containsKey(index)) {
            position[0] = check.get(index);
            position[1] = i;
            return position;
        } else {
            check.put(nums[i], i);
        }
    }
    return position;
}
```

[相关代码](https://github.com/clwater/Code/blob/master/src/SumOfTwoNumbers.java)欢迎大家关注并提出改进的建议
