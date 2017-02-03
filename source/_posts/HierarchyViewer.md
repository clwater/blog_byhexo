---
title: Android Tools 之一 Hierarchy Viewer
date: 2017-02-03 18:02:56
tags: ["android" , "view" , tools" , "Hierarchy Viewer"]
categories: "android"
---
# Android Tools 之一 Hierarchy Viewer

>本系列旨在介绍一些被忽略的优质工具 毕竟 能被当做自带的工具总有些做的比较好的地方不是

## Hierarchy Viewer

Hierarchy Viewer是一个可以用来查看View的使用工具 android sdk中自带

[Optimizing Your UI -官方网站 需科学上网](https://developer.android.com/studio/profile/optimize-ui.html#lint)

### 启动Hierarchy Viewer

hierarchyviewer工具在sdk/tools路径下
<!-- more -->

再次打开后会出现如下提示
```
The standalone version of hieararchyviewer is deprecated.
Please use Android Device Monitor (tools/monitor) instead.
```
主要想说的就是 单独使用hieararchyviewer已经不被建议  建议使用Android Device Monitor(Android Device Monitor的相关使用后续会详细介绍)

直接运行monitor或者在在Android Studio -> tools -> android -> Android Device Monitor中将hieararchyviewer工具打开

**以下对hieararchyviewer工具进行操作均为直接打开hieararchyviewer工具 和通过monitor工具打开的hieararchyviewer的UI可能略有不同  以直接打开hieararchyviewer工具操作为准**


#### 无法正常使用

在连接过程中可能遇到无法连接到手机的问题 详情参考以下文章

[HierachyViewer无法连接真机调试](http://blog.csdn.net/yafeng_0306/article/details/17224001)

[HierachyViewer无法连接真机调试详解](http://maider.blog.sohu.com/255448342.html)

### 使用Hierarchy Viewer

![Hierarchy Viewer 1-1](http://i1.piimg.com/567571/95498e5576c157e1.png)

成功连接后会出现如上页面

当前页面正在显示的进程被加粗显示

(那些看着是空的位置 进入后会显示通知栏中的View布局)

选择想要查看的进程后进入 Load View Hierarchy页面

![Hierarchy Viewer 1-2](http://p1.bpimg.com/567571/08b13a1f4b3c6b97.png)

下面对不同部分分别介绍一下

![Hierarchy Viewer 1-3](http://i1.piimg.com/567571/ed16834323343ea2.png)

1. Save as PNG: 把这个布局的层级另存为png格式
2. Capture Layers: 把这个布局的层级另存为psd格式

  可以查看各层级的情况

  ![Capture Layers](http://i1.piimg.com/567571/62b7d9584993e3a1.png)

3. Load View Hierarchy: 重新载入这个view层级图
4. Evaluate Contrast: 查看层级布局的具体情况

  ![Evaluate Contrast](http://i1.piimg.com/567571/594698903a3e6fa1.png)

5. Display View: 在单独的一个窗口中显示所选择的view
6. Invalidate Layout: 重绘当前窗口
7. Request Layout: 对当前view进行layout
8. Dump DisplayList: 使当前view输出它的显示列表到logcat中
9. Dump Theme: 下载这个view主题的资源
10. Profile Node: 得到measure，layout，draw的性能指示器

![Hierarchy Viewer 1-6](http://p1.bpimg.com/567571/b7a6efcd6d505116.png)

选取某个view节点可以查看选取的View的详情

![Hierarchy Viewer 1-6](http://i1.piimg.com/567571/3b66b1216e20e81d.png)

关于View的渲染机制可以参考一下本人关于android View相关机制解析的文章 [Android View 相关源码分析之三 View的绘制过程 ](http://www.jianshu.com/p/8f3e45663d06)

关于对应渲染时间的速度中  我么知道View绘制分为measure layout 和draw三个过程 三个点分布对应以上三个过程 分为绿 黄 红三个颜色  绿色代表该View在本view tree中速度是前50% 黄色表示后50% 而红色表示是花费时间最长的

还记得最开始使用Hierarchy Viewer中上方有Inspect screenshot的按钮 可以查看当前Activity的像素情况

![Inspect screenshot](http://p1.bqimg.com/567571/82cd3eeaf8663969.png)

(层级十分的清晰 就不仔细解释了)

解释下相关功能

1. Save as PNG: 保存当前显示的页面为png格式
2. Refresh Screenshot: 刷新像素视图和放大镜视图(右边那两个)
3. Refresh Tree: 刷新View tree
4. Load Overlay: 在右侧放大镜视图中中加载一个覆盖图(官网中没有给出详细的定义 主要根据相关介绍理解 略有偏差 欢迎指出)
5. Show In Loupe: 在中间的像素视图中显示之前加载的图片
6. Auto Refresh: 会根据下发设置的Refresh Rate的时间自动
更新View tree


以上
