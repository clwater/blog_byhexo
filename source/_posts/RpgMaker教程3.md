---
title: RpgMaker教程3
date: 2017-10-04 17:05:26
tags: ["Rpg Maker" ]
categories : "RpgMaker 教程"
---

> 开始填坑的我

# RpgMaker入门教程3

## 第三回 让我们开始制作城堡
在第二回中我们创建了一个新的项目 并制作了世界地图

![第二回创建的世界地图](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/53054520.jpg)

<!-- more -->

下一个阶段 我们将创建对应标识(城镇及地下城)的内容

### Step6 开始制作城堡的地图
#### 创建一个新的地图
在编辑器左下角的"世界地图"标签中右键 选择新建地图 来创建一个新的地图

![冒险开始的城堡地图](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/41194854.jpg)

根据上面图片对新的地图属性进行设置,将地图名称更改为“冒险开始的城堡地图” ,地图大小设置为默认宽度17和高度13,它是一个只有一个屏幕的大小的地图,别忘了设置BGM.

#### 绘制城堡地图
我们要绘制一张地图,我们想象一下国王在城堡中生活的场景

![城堡内国王生活的地方](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/29932479.jpg)

通过瓷砖 柱子 还有进行装饰,并将国王放在地图的中间,并在下部设置一个出人口.

### Step7 创建一个简单的"场所移动"时间

刚刚创建的地图之间是互相独立的,我们要通过"事件"来将不同的地图相互联系起来.

下面我来简单介绍一下什么是 "事件"

在RPG Maker中,我们常常使用"事件",这是游戏中发生的事件的统称.比如城镇中的提示,宝箱和宝物,地图之间的连接,现在开始你可以显示交流和使用物品,任何游戏中发生的事情都是使用的事件.

#### 将世界地图和城堡的地图连接

在RPG Maker中,我们使用"事件"功能很方便,可以很方便的创建一个"事件",只需要在菜单中选择事件模式.

![选择事件模式](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/20019323.jpg)

![快速创建事件](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/69495280.jpg)

<center>快速创建一个"事件"</center>

将鼠标移动到城堡的出口位置,右键选择 快速创建事件->场所移动 的事件

![场所移动事件的对话框](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/46059419.jpg)

<center>场所移动事件的对话框</center>

选择后会显示一个用于创建 场所移动 事件的对话框


![目的地地图](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/97806613.jpg)

<center>目的地地图</center>

在目的地地图中,选择"世界地图",双击指定目标坐标.关于"方向"是目标移动后指向的位置.如果没有特殊要求,可以直接使用默认的设置.

选择"确认"后"开始城堡"->"世界地图"的场所移动事件就完成了

现在你可以从"城堡地图"移动到世界地图,但是还不能从"世界地图"移动到"开始城堡".通过同样的方式,我们创建一个"世界地图"到"城堡地图"的场景事件.

![快速创建事件](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/35890321.jpg)
<center>快速创建事件</center>

将光标移动到指定位置 创建一个"场景移动"事件.

![指定目的地及坐标](https://qiniu-ali-oss.oss-cn-hangzhou.aliyuncs.com/qiniuold/52224203.jpg)
<center>指定目的地及坐标</center>

像之前一样 将目的地设置为城堡地图的入口位置,这样我们就能在"世界地图"和"城堡地图"之间移动了.

只有从一个位置移动到另一个位置的"场景移动"世界是失败的.这样会让我们的游戏只能单向运动.最后我们别忘了测试一下两个场景能否正常的连接.
