---
title: shel(一)--基础
date: 2020-03-19 16:51:32
tags:
---

# shell(一) -- 基础

## 什么是shell
先看下官方的定义

> Unix shell：一种壳层与命令行界面，是Unix操作系统下传统的用户和计算机的交互界面。普通意义上的shell就是可以接受用户输入命令的程序。它之所以被称作shell是因为它隐藏了操作系统低层的细节。Unix操作系统下的shell既是用户交互的界面，也是控制系统的脚本语言。

翻译过来就是说,Shell 是一个应用程序,它连接了用户和 Linux 内核，让用户能够更加高效、安全、低成本地使用 Linux 内核.

shell可以理解为一个特殊的应用程序

shell本身是由c语言编写而成的,shell实际上是一直解释性语言

  <!-- more -->

## shell和bash的区别
这两个是包含的关系,bash是shell的一种,其中linux默认的shell就是bash.

bash可以说是shell的脚本解释器


## 第一个shell脚本

``` shell
#!/usr/bin/env bash

#像前面所说的,bash是shell的脚本解释器. 
#这种写法可以最大程度的避免夸平台下脚本无法运行的问题
#后面相关文件均使用此默认配置

echo "Hello World"

# echo是shell中的输出方法
```

至此 一个最简单的shell脚本就完成了,我么可以在终端中运行查看效果

![1](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f393d980?w=726&h=115&f=png&s=88801)
(在初次运行中可能出现permission denied的情况, 对应的增加权限即可)

## 变量
```shell
name='clwater'

echo $name
echo "$name"
echo "${name}!"

echo '$name'
```

需要注意的的是在对变量赋值的时候,'='前后都不可以有空格,不然是无效的

下面展示了三种常见的变量使用的情况, 变量在使用的时候都需要在前面加入'$'符号来调用变量.

* echo $name
最基础的变量使用
* "\$name" 和 "\${name}!"
针对在使用时需要拼接的情况,可以通过'{}'符号来定位变量名的范围
* "\$name" 和 '\$name'
在""内的\$变量的格式是可以正常使用的,不过在''中的内容会保持其原有的内容输出

![2](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f46b96f3?w=665&h=81&f=png&s=38701)

## 函数简介
```shell
get_name() {
  echo "clwater"
}

get_name

echo "You are $(get_name)"
echo "You are `get_name`"

result=$(get_name)
echo "result: $result"
```

输出结果:

![3](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f4b05a84?w=118&h=65&f=png&s=14640)

我们可以通过
```shell
functionName() {
    ...
}
```
这样的形式来定义一个函数(如何穿参参考后面函数部分),调用的时候也是否的简洁,直接调用相关的函数名即可,除此之外可以通过以下方法获取此函数的返回值

```shell
$(functionName)
`functionName`
```

故此我们可以把返回值存起来以便后面的使用

shell的函数只能返回一个string类型的字符串,shell中没有我们平常使用的return关键字,使用的是echo输出的内容作为其函数的返回值,具体相关的在后面的函数中详细的介绍

## 状态码
在shell中,我们常常需要知道上一次的命令执行是否成功来决定下一步怎样执行

```shell
result=$(cd ~/ 2>&1)
echo "cd ~/ status $?"  --> 0
result=$(cd ~/errorPath 2>&1)
echo "cd ~/errorPath status $?" --> 1
```

2>&1的作用是一直重定向的功能,可以把错误输出定向为标准输出(这里的作用是 把cd操作错误的情况定位为返回值的输出)

$?的作用是获取上一个命令的状态码,当状态码为0的时候,说明上次的指令是成功执行的,非0的情况说明上次的指令没有成功执行


## 条件执行 &&和||
```shell
cd ~ && pwd
cd ~/errorPath || echo "cd error"
```
![4](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f5578595?w=519&h=57&f=png&s=31121)

&&是在前一个命令执行成功(状态码为0)的情况下执行后面的命令

||是在前一个命令执行失败的(状态码非0)的情况下执行后面的命令

(这里没有使用2>&1之类的重定向,所以报错信息会被输出到控制台)

## 条件控制

```shell
name="clwater"
if [[ name == "clwater" ]]; then
  echo "Hi, $clwater"
else
  echo "Hi, new friends"
fi
```

可以通过
```shell
if [[ 判断条件 ]]; then
    ...
fi
```
的形式来实现一个if判断(详情可以参考下后面的条件控制相关内容)

## 花括号展开
```shell
echo {1..5}
echo {A,B}
echo {1,3}{A..C}
echo {{1..3},{A,C}}

name='clwater'
echo {a,b}$name
```

![5](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f5359496?w=152&h=89&f=png&s=19320)


在{}中设置其展开的内容,其中','为选择,'..'为范围,花括号展开在整个shell中具有最高的优先级


## 严格模式

``` shell
set -euo pipefail
IFS=$'\n\t'

error1
error2
error3
```
![6](https://user-gold-cdn.xitu.io/2019/8/13/16c8b797f564fbc3?w=315&h=86&f=png&s=35598)

我们可以看到,在使用严格模式的情况下,如果命令出现任意错误,都会报错并停止执行,而不使用严格模式的情况下,即使命令出现错误了  也继续执行下去

## 相关代码
相关代码可以访问[这里](https://github.com/clwater/awe-shell/blob/master/code/1.sh)