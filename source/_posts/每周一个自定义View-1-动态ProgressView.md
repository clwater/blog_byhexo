---
title: 每周一个自定义View(1) -动态ProgressView
date: 2021-06-03 21:54:14
tags:
---

# 每周一个自定义View(1) -动态ProgressView
> 新的一个系列, 应该是计划每周实现一个自定义View, 看看能检查到多久吧

>这次就从一个常见的ProgressBark开始吧, 最近的项目中使用了一个Progress显示文件下载进度的功能, 设计给的是一个静态的图片, 也没有说需要具体实现的情况, 后面优化的时候刚好有了性质, 就有了下面的这个AnimatorProgressBar.

## 效果展示
<img src="https://update-image.oss-cn-shanghai.aliyuncs.com/blog/prorgessview/progressview.gif" width = "300" height = "500" alt="ProgressView" align=center />

### 支持功能
* 基本的的进度设置(当前默认为0-100)
* 颜色定义, 使用的颜色都是可以设置的, 满足各样的ui需求
* 元素定义, 作为展示的Progress中的线条可以设置宽度和间距
* 动画控制, 动画效果可以设置展示速度, 总有一个组合适合你

### 设计过程
![图层](https://update-image.oss-cn-shanghai.aliyuncs.com/blog/prorgessview/WX20210603-221636.png)

将相关的view分为了四层, 从下至上分别为

* 背景图层
 用于显示整个view的背景
* 进度图层
 相当于进度条的背景颜色
* 线段动画图层
 在这里绘制出现的线段, 并控制器动画的效果
* 遮罩展示图层
 这里使用了遮罩展示的方法, 控制遮罩图层的进度和样式来表现实际的展示效果