---
title: 'LeetCode27-RemoveElement(移除元素)'
date: 2019-02-17 15:45:05
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode27-RemoveElement(移除元素)

[LeetCode:https://leetcode-cn.com/problems/remove-element/](https://leetcode.com/problems/remove-element/)

[LeetCodeCn:https://leetcode-cn.com/problems/remove-element/](https://leetcode-cn.com/problems/remove-element/)

## 题目描述
给定一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，返回移除后数组的新长度。

不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。

元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
<!-- more -->

## 示例
* 示例 1:
  * 给定 nums = [3,2,2,3], val = 3,
  * 函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。
  * 你不需要考虑数组中超出新长度后面的元素。

* 示例 2:
  * 给定 nums = [0,1,2,2,3,0,4,2], val = 2,
  * 函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。
  * 注意这五个元素可为任意顺序。
  * 你不需要考虑数组中超出新长度后面的元素。

## 解题方法-双指针
应为可以更改其中数据的顺序并且需要原地修改内容,类似'删除排序数组中的重复项'中双指针的方法,不过这里我们的两个指针分别从数组头(l)和数组尾(r)向中心移动校验,当l遇到需要移除的元素时,之间将其内容更换为r所指向的内容,并将r向中心移动,当l指向的内容非需要移除的内容时,将l向中心移动,知道l在r的右侧

## 图解相关思路
下面我们以[0,1,2,2,3,0,4,2],删除2内容为例.l为左侧指针,默认为数组首位,r为右侧指针默认为数组末位.两个指针都向中心移动

![0](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217203754.png)

当l指向的元素(0,1)不为需要移除的元素(2)时,仅移动l指针

![1](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217203839.png)

当l指向2时,移动r所指向的元素(2)到l的位置,并仅移动r指针(l指针不移动,下次验证l的时候会对移动来的数据进行校验)

![2](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217204155.png)

当我们再次校验l的内容时,将r指向的4移动到原来l指向的内容2
中,并仅移动r指针

![3](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217204555.png)

我们再次校验l的内容,发现不需要更改,仅移动l指针即可

![4](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217204740.png)

类似的,更改下一次l内容为r的内容

![5](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217205024.png)

知道l指针的位置不在r的左侧,此时r的位置就是此数组的有效位置

![6](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190217205212.png)

## 代码实现
```java
public int removeElement(int[] nums, int val) {
    int l = 0;
    int r = nums.length;
    while (l < r){
        if (nums[l] == val){
            nums[l] = nums[r - 1];
            r--;
        }else {
            l++;
        }
    }
    return r;
}
```

[相关代码](https://github.com/clwater/Code/blob/master/src/RemoveElement.java)欢迎大家关注并提出改进的建议
