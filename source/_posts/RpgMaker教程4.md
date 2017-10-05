---
title: RpgMaker教程4
date: 2017-10-04 23:10:45
tags: ["Rpg Maker" ]
categories : "RpgMaker 教程"
---

# RpgMaker教程4

在第三回教程中,我们使用了简单的"场景事件" 来进行两个地图页面之间的交互

![开始冒险的城堡](http://ooymoxvz4.bkt.clouddn.com/17-10-4/29932479.jpg)

<!-- more -->

这一回中我们要在城堡中和国王开始交谈.在这里我将使用"开关"

## Step8 和国王进行交谈

我们要设置一个国王,来告诉我们的主角 冒险的目的(打败魔王)

### 启动事件编辑器

![事件编辑器](http://ooymoxvz4.bkt.clouddn.com/17-10-4/94566665.jpg)
<center>将模式设置为事件模式</center>

![指定国王的位置](http://ooymoxvz4.bkt.clouddn.com/17-10-4/86250828.jpg)
<center>指定国王的位置</center>

将光标放置在王座的坐标中.

![新建事件
](http://ooymoxvz4.bkt.clouddn.com/17-10-4/53707291.jpg)

<center>右键选择 新建</center>

右键单击弹出弹出菜单,然后选择事件

![事件编辑页面](http://ooymoxvz4.bkt.clouddn.com/17-10-4/98409700.jpg)
<center>事件编辑页面</center>

> 创建事件

创建事件的时候打开此事件编辑器,在事件编辑器中可以对事件的出现条件及事件的执行进行调整.看起来有很多的条目,不过根据不同的事件内容可以设置项目的默认设置.


### 选择显示的图像

选择游戏中事件显示的时候展示的图像

![时间编辑器-图像](http://ooymoxvz4.bkt.clouddn.com/17-10-5/23818705.jpg)

<center>事件编辑器->图像</center>

双击展示图像的部分

![从列表中选择一个图像](http://ooymoxvz4.bkt.clouddn.com/17-10-5/32052553.jpg)
<center>从列表中选择一个图像</center>

### 输入文本信息

输入国王对主角的对话,双击"执行内容"中的"♦"标识,显示事件指令的列表页面.

> 事件指令
事件指令是用于创建事件的指令.根据你需要的操作,会通过不同的命令来实现事件.

![事件指令列表第一页](http://ooymoxvz4.bkt.clouddn.com/17-10-5/11996036.jpg)
<center>事件指令列表第一页</center>

如果需要在游戏中显示文字对话类的功能,使用"显示文字"事件指令


![显示文字对话框](http://ooymoxvz4.bkt.clouddn.com/17-10-5/82599265.jpg)
<center>显示文字对话框</center>

在"文本"部分输入文字.我们把国王需要说的话输入文本中.最多可以在一个消息窗口中显示四行文字.

![国王的对话](http://ooymoxvz4.bkt.clouddn.com/17-10-5/71970098.jpg)

<center>国王的对话</center>

### 在对话中显示脸部的图形

双击"脸部"选择脸部图形.脸部图形的设置不是必要的,但是这里要描述一个很严肃的事情,我们要展示国王的面貌.

![脸部图像选择](http://ooymoxvz4.bkt.clouddn.com/17-10-5/44809148.jpg)

<center>脸部图像选择</center>


![国王的面貌设置成功](http://ooymoxvz4.bkt.clouddn.com/17-10-5/63479279.jpg)

<center>国王的面貌设置成功</center>


![事件设置完成](http://ooymoxvz4.bkt.clouddn.com/17-10-5/80687801.jpg)

<center>最后,我们确认我们所设置的时间</center>

## Step9 "开关"事件管理

让我们来看看国王的事件能否正常运作,进入城堡地图,与国王交谈.

![与国王进行对话](http://ooymoxvz4.bkt.clouddn.com/17-10-5/67782517.jpg)
<center>与国王进行对话</center>

在这里我们可以和国王正常的对话,但是每次对话的时候都显示同样的对话,再第二次和国王对话的时候我们需要展示另一端文字.

>开关
开关是游戏中的对逻辑进行处理的一个重要的部分.单个开关可以在两个状态之间进行切换.即on和off,所有开关的初始状态都为off.例如,当我们想要记录"我和国王的对话"时,就打开开关.那就意味着"某个开关是on"="我和国王对话" 你可以将某个开关的状态作为一个标记.


通过开关 我们记录和国王的对话,当第二次和国王对话时显示不同的文字.

重新打开之前的事件.

![在活动编辑中打开和国王对话的事件](http://ooymoxvz4.bkt.clouddn.com/17-10-5/57980213.jpg)

<center>在事件编辑中打开和国王对话的事件</center>

![选择开关操作](http://ooymoxvz4.bkt.clouddn.com/17-10-5/19184781.jpg)

<center>选择开关操作</center>

在事件编辑的页面中 选择最下方的"◆"的标记 并选择 游戏基础-> 开关操作

![开关操作页面](http://ooymoxvz4.bkt.clouddn.com/17-10-5/90912760.jpg)

<center>开关操作页面</center>


![切换选择开关](http://ooymoxvz4.bkt.clouddn.com/17-10-5/69924241.jpg)

<center>切换选择开关</center>

![为开关命名](http://ooymoxvz4.bkt.clouddn.com/17-10-5/7236016.jpg)

<center>为开关命名</center>

![将操作设置为"on"状态](http://ooymoxvz4.bkt.clouddn.com/17-10-5/28254544.jpg)

<center>将操作设置为"on"状态</center>

选择开关操作中的,单个模式,选择右边的[...]按钮,切换到选择开关页面,并选择"0001"开关.每个开关都可以单独命名,为了方便后面的使用,我们可以设置一个描述性的名称.我们把0001的开关设置为"与国王的对话",确认后将该开关的操作设置为"on"状态.

![设置完成后效果](http://ooymoxvz4.bkt.clouddn.com/17-10-5/4210409.jpg)

<center>设置完成后效果</center>

## Step10 通过开关控制事件的内容

我们可以使用开关来控制"与国王的交谈"的内容.接下来,当我们第二次和国王交谈后,我们将通过开关来控制事件.

![创建新的事件页](http://ooymoxvz4.bkt.clouddn.com/17-10-5/31500917.jpg)

<center>创建新的事件页面</center>

我们创建第二个标签页.通过不同的标签页,我们可以对同一个事件设置不同的执行情况.


![新的页面内容](http://ooymoxvz4.bkt.clouddn.com/17-10-5/26324215.jpg)
<center>新的页面内容</center>

在新的标签页中我们设置当我们第二次及之后和国王对话时的事件.

![设定出现条件](http://ooymoxvz4.bkt.clouddn.com/17-10-5/76067516.jpg)

<center>设定出现条件</center>

首先在标签页中设置"出现条件"中的"开关"部分,并将其指定为开关"0001:与国王的对话".通过这样的设置,当开关"0001:与国王的对话"的状态为"on"时就会执行第二个事件页的内容,而不是第一事件页.

![设置新的事件](http://ooymoxvz4.bkt.clouddn.com/17-10-5/17782736.jpg)

<center>设置新的事件</center>


在第二个事件页中设置新的对话事件.


![和国王的第一次对话](http://ooymoxvz4.bkt.clouddn.com/17-10-5/32658030.jpg)

<center>和国王的第一次对话</center>

![和国王的第二次对话](http://ooymoxvz4.bkt.clouddn.com/17-10-5/79367740.jpg)

<center>和国王的第二次对话</center>

至此 我们完成了和国王的对话事件œ
