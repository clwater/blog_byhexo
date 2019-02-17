---
title: 'LeetCode26-RemoveDuplicatesFromSortedArray(删除排序数组中的重复项)'
date: 2019-02-16 22:48:07
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode26-RemoveDuplicatesFromSortedArray(删除排序数组中的重复项)

[LeetCode:https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)

[LeetCodeCn:https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/)

## 题目描述
给定一个排序数组，你需要在原地删除重复出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。

不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。

## 示例
* 示例 1:

  * 给定数组 nums = [1,1,2],
  * 函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。
  * 你不需要考虑数组中超出新长度后面的元素。

    <!-- more -->

* 示例 2:
  * 给定 nums = [0,0,1,1,1,2,2,3,3,4],
  * 函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。
  * 你不需要考虑数组中超出新长度后面的元素。

## 解题方法-双指针
创建两个指针,分别指向新数组的长度(result)和检测元素的位置(index),如果index和result指向的元素不同,则将index指向的的元素移动到result的下一位.

## 图解相关思路
我们以排序[0,0,1,1,2,3,4]数组为例.并创建result和index两个指针,初始均指向首位

![初始](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216232427.png)

当index=0时,result和index指向的元素值都为0,则result不更改,index向后移一位

![index=0](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216232732.png)

当index=2时,此时分别对应的元素为1和0,两值并不相同

![index=20](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216232913.png)

则此时index和result均需要向后移动一位,并且需要将result移动后指向的内容更改为index移动前的数据

![index=21](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216233041.png)

类似的,在移动index的时候检查其和result的数值十分相同,直到index将此数组遍历完成
![index](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216233626.png)

因为result是从0开始的,返回新数组的长度时要将其+1.

## 代码实现
```java
public int removeDuplicates(int[] nums) {
    int result = 0;
    for (int index = 0; index < nums.length ; index++){
        if (nums[result] != nums[index]){
            result++;
            nums[result] = nums[index];
        }
    }
    return result +1;
}
```

[相关代码](https://github.com/clwater/Code/blob/master/src/RemoveDuplicatesFromSortedArray.java)欢迎大家关注并提出改进的建议
