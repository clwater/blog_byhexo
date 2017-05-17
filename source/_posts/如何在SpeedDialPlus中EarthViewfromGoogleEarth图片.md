---
title: 如何在SpeedDialPlus中EarthViewfromGoogleEarth图片
date: 2017-05-17 23:56:45
tags: ["peed Dial Plus" , "Earth View from Google Earth" , "Chrome插件" , "Python"]
categories: "Python"
---

# 如何在Speed Dial Plus中Earth View from Google Earth图片

## 介绍
Speed Dial Plus和Earth View from Google Earth都是Chrome中的两个十分好用的新标签页插件

Speed Dial Plus可以在你打开一个新的标签页的时候提供经常访问的页面的快捷方式 虽然还有很多扩展, 但是这个功能真心好用
![Speed Dial Plus](http://ooymoxvz4.bkt.clouddn.com/17-5-18/39416953-file_1495036928867_860e.png)

Earth View from Google Earth可以在你打开一个新的标签页的时候展示一副google earth拍摄的图片(虽然只有1500多个图片 但是每幅图都是十分别致的)
![Earth View from Google Earth](http://ooymoxvz4.bkt.clouddn.com/17-5-18/62579920-file_1495037085098_d853.png)

## 需求
这两个都是十分优秀的标签页的工具,那么问题就是 这两个不能共同使用 虽然SDP提供了设置背景页面的方法,但是每次只能设置成一个页面

## 解决思路
通过分析Earth View from Google Earth来获取所有图片的地址 再在本地或者自己的服务器中部署一个服务器 可以随机返回有效图片地址中的一个 再将SDP中设置背景为自己的服务器设定的地址

最终实现打开新标签页(SDP) SDP访问你的服务地址 服务随机返回一个图片地址 SDP最终访问你设定的新的图片地址

## 分析Earth View from Google Earth 
