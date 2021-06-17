---
title: 每周一个自定义View-2-动态ProgressViewTip2
date: 2021-06-17 21:34:51
tags:
---

# 每周一个自定义View-2-动态ProgressViewTip2

> 其实功能周一就已经实现了, 不过后面的内容感觉比功能的实现还繁琐

照理先看下效果, 这里可以看到, 随着进度的变化越快, tip偏移的角度也越大, 给人一种加速度高的感觉
![动画效果](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617215220.gif)


## 设计过程
### 静态分解
这个view整体看来还是比较简单的, 可以分成背景和文字的展示

![静态分解](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617220232.gif)

背景的话可以看做一个圆角矩形和一个等边三角形, 显示的文字的话只要让文字在矩形的中心显示就可以了

### 动画效果
动画效果也比较简单, 根据当前需要变化的进度按照比例来旋转整体的角度即可
![动画效果](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617221840.gif)


### 