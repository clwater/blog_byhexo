---
title: Android杂货店-一次自动化测试的记录
date: 2021-06-10 21:28:52
tags:
---

# Android杂货店-一次自动化测试的记录

> 是的, 每周一个自定义View的系列第二周就咕咕咕了, 因为我平时使用的工具各种各样, 实在是没有什么办法归为一类来处理, 现在想想, 这里平时实际工作使用的工具反而是更应该分享给大家的, 于是便有了现在新的系列Android杂货店, 多吃才能更好学习不是.

## 背景
最近一直在做一个蓝牙通信的项目, 由于通信的情况不是很稳定, 就像做一个冒烟测试看一下具体的情况, 不过现场十分的复杂, 需要延时通信, 异步的获取结果, 在根据结果决定相关的操作, 既不是白盒也不是黑盒. 因为是针对开发功能的测试, 纯黑盒的情况下无法获取到一些检测的数据, 而纯白盒的情况下又有许多的功能以及被集成, 只不过没有数据的显示. 加之功能测试流程复杂, 重复性高, 最后通过adb和shell进行了测试

<!-- more -->

## 设计与实现
测试的设计来说还是比较简单的, 打开应用-> 检查状态 -> 测试功能1 -> 测试功能2 -> 退出应用 -> 统计信息 -> 下一次循环测试

不过现实起来还是比较麻烦, 既有log日志的信息截取, 还有页面点击的事件触发, 在测试背景也不是需要十分的标准, 需要一个快速测试验证的情况下, 排查了使用辅助功能或者现有的黑白盒测试工具, 采用了adb+shell的方式

简单来说通过adb 来进行输出数据和进行功能控制, 通过shell来进行统计和数据检查和流程控制

## 工具使用
一般来说, 都是先上代码, 不过这次的情况比较特殊, 需要先介绍许多背景工具的信息, 不然代码对应平时没有这么方面基础的开发者来说可能就难以理解了
### adb
adb作为Android开发者来说接显得熟悉的多了, 不过我还是要把使用到的功能进行一个简单的介绍(篇幅有限, 并且很多工具的某个功能详细来说可能就能做一个新的文章了)

adb(Android Debug Bridge), 可以理解为应用开发的一个桥接, 也是用作测试中数据输出和功能控制的的原因

* adb devices: 用于查看当前电脑连接到的手机设备列表, 当有多台设备的时候就可以通过此指令查看需要控制的设备的标识.
* adb -s [deviceId]: 用于通过adb控制指定的设备
* adb logcat -s AUTO_TEST: 用于输出手机中的logcat信息, -s AUTO_TES可以过滤到指定的tag
* adb shell am: am是Activity Manger的缩写, 可以用于控制手机的Activity, 当前使用了**adb shell am force-stop com.clwater.test**可以关闭指定的应用, **adb -s $deviceID shell am start -n com.clwater.test/clwater.test.StartActivity**可以打开指定的应用
* adb shell input tap [x_posotion] [y_position]: 点击手机的指定位置, 可以在开发者模式中显示坐标的信息来获取坐标的情况, 类似的还可以模拟长按或者是滑动等相关的操作


### shell
* 方法函数
```shell
   #方法的定义,
   function functionName(){
       # echo 输出的内容可以认为是返回值
       # $1 为第一个入参的参数
       # $2 为第二个入参的参数
       echo "$1 $2"
   }
   #方法的使用 其中a和b为入参的参数
   functionName a b
   # 其中需要注意的是, shell为解释型, 如果需要定义变量或方法, 需要在调用前定义好才能调用
```
* 获取方法的执行结果, 如果想要知道某些代码的执行结果, 可以通过 **\`(执行语句)\`** 或者 **$(执行语句)**来获取
* 变量的使用 在使用定义好的变量时需要在遍历前添加 **$**来使用
* sed sed可以理解为针对文件进行处理的工具, 此处 **sed -n '1p' \$localCountPath** 为获取localCountPath路径下文件第一行的信息, 当然sed的功能不只有有这个, sed是拥有许多十分强大的功能
* awk awk为一个文本分析工具,此处 **awk "BEGIN{print $1/$2*100 }** 为计算第一个参数/第二个参数*100的结果
* tail 用于查看文件内容, **tail -n 1 $logPath**为查看logPath文件的最后一行的内容
* 输入输出重定向, 一般用于读取或输出内容, 其中 **>>**为将输出以追加的方式重定向到指定文件, **>**为输出重定向到指定文件
* 字符串截取 **${log##*AUTO_TEST:}**为从左到右输出最后一个AUTO_TEST:字段后的内容
* if与while, 常见的判断与循环, 这里就不过多的阐述了
* ==与=~, 其中==为相等, =~为正则匹配


## 代码实现
```shell
#/bin/bash

deviceID="9SV9X20829K00123"

logPath="本地log.log"
localCountPath="统计信息.txt"

# 检查标志位
checkJump=10000

success="success"
fail="fail"

# 从历史文件中获取历史的信息
# 参考shell sed的使用
startCount=`(sed -n '1p' $localCountPath )`
connectCount=`(sed -n '2p' $localCountPath )`
connectSuccess=`(sed -n '3p' $localCountPath )`
genericCount=`(sed -n '4p' $localCountPath )`
genericSuccess=`(sed -n '5p' $localCountPath )`
startOtaCount=`(sed -n '6p' $localCountPath )`
startOtaSuccess=`(sed -n '7p' $localCountPath )`
progressOtaCount=`(sed -n '8p' $localCountPath )`
successProgressOtaCount=`(sed -n '9p' $localCountPath )`


# 获取当前最新的log
function checkLog()
{       
    # 获取当前目标文件的最新信息
    # 参考shell tail的使用
    log=`(tail -n 1 $logPath)`
    # 分割有用的信息
    # 参考sehll 字符串的分割
    log=${log##*AUTO_TEST:} 

    echo $log
}

# 进行相关动作检查
# $1 需要进行检查的动作
# $2 进行检查的时间
function testCheck(){
    _index=0
    while [ $_index -lt $2 ]
    do
        let _index=($_index + 1)
        # 获取当前最后一行的log
        # 参考shell 方法的调用
        if [[ `(checkLog)` == $1 ]];
        then
            _index=$checkJump
            echo $success
        else
            sleep 1
        fi        
    done
    if [[ $_index != $checkJump ]]
    then
        echo $fail
    fi
}


# 显示某个流程的统计信息
function showItemCount(){
    # $1与$2 参考shell 方法的使用
    if [[ $2 != 0 ]];
    then
        # 计算百分比的情况
        # 参考shell awk的使用
        f=$(awk "BEGIN{print $1/$2*100 }")%
    else
        f="0%"
    fi
    
    echo "$1/$2($f)"
}

# 保存信息到本地
function saveLoacl(){
    # 参考shell > 与>>的使用 
    echo $startCount > $localCountPath

    echo $connectCount >> $localCountPath
    echo $connectSuccess >> $localCountPath
    echo $genericSuccess >> $localCountPath
    echo $genericCount >> $localCountPath
    echo $startOtaCount >> $localCountPath
    echo $startOtaSuccess >> $localCountPath
    echo $progressOtaCount >> $localCountPath
    echo $successProgressOtaCount >> $localCountPath
}

# 显示统计信息
function showCount(){
    
    echo "启动: $startCount"
    echo "测试流程1: `(showItemCount $connectSuccess $connectCount)`"
    echo "测试流程2: `(showItemCount $genericSuccess $genericCount)`"
    echo "测试流程3 : `(showItemCount $startOtaSuccess $startOtaCount)`"
    echo "测试流程4 : `(showItemCount $successProgressOtaCount $progressOtaCount)`"
    saveLoacl
    
}

# 推出应用
function exitApp(){
    echo "关闭应用"
    # 参考adb shell am方法 退出指定应用
    `(adb -s $deviceID shell am force-stop com.clwater.test)`

    showCount
}

# 测试流程4
function checkOTAProgress(){
    echo "测试流程4"
    let progressOtaCount=($progressOtaCount + 1)

    _index=0
    # 达到延时120s后进行异常进行处理
    # 参考shell while指令
    while [ $_index -lt 120 ]
    do
        let _index=($_index + 1)
        log=`(checkLog)`
        # 参考shell =~正则匹配
        if [[ $log =~ "测试流程4_正则" ]];
        then
            _index=$checkJump

            if [[ $log == "测试流程4_状态1" ]];
            then
                let successProgressOtaCount=($successProgressOtaCount + 1)
                echo "测试流程4_状态1"
                sleep 5
                exitApp
            else
                echo "测试流程4_状态2"
                exitApp
            fi
        else
            sleep 1
        fi        
    done

    if [[ $_index != $checkJump ]]
    then
        echo "测试流程4_状态超时"
        exitApp
    fi
}

# 测试流程3
function checkOTA(){
    let startOtaCount=($startOtaCount + 1)
    echo "测试流程3 预处理1"
    sleep 3
    echo "测试流程3 预处理2"

    # 模拟屏幕点击
    # 参考adb shell input 方法
    `(adb -s $deviceID shell input tap 658 1130)`

    sleep 5
    echo "测试流程3 预处理3"
    `(adb -s $deviceID shell input tap 530 1960)`
    sleep 1
    echo "测试流程3中...(20s)"

    statu=`(testCheck "测试流程3" 20)`
    
    if [[ $statu == $success ]];
    then
        let startOtaSuccess=($startOtaSuccess + 1)
        echo "测试流程3成功"
        checkOTAProgress
    else
        echo "测试流程3失败"
        exitApp
    fi

}

# 测试流程2
function checkGeneric(){
    let genericCount=($genericCount + 1)
    echo "测试流程2...(30s)"
    statu=`(testCheck "测试流程2" 30)`
    
    if [[ $statu == $success ]];
    then
        let genericSuccess=($genericSuccess + 1)
        echo "测试流程2成功"
        checkOTA
    else
        echo "测试流程2异常"
        exitApp
    fi
}

# 测试流程1
function checkConnect(){
    let connectCount=($connectCount + 1)
    echo "测试流程1检查中...(30s)"
    statu=`(testCheck "测试流程1" 30)`
    
    # 参考 shell if 的使用
    if [[ $statu == $success ]];
    then
        let connectSuccess=($connectSuccess + 1)
        echo "测试流程1成功"
        checkGeneric
    else
        # 异常流程可以根据异常的情况决定接下来的流程
        # 当前为异常情况下推出应用 
        echo "测试流程2成功"
        exitApp
    fi
}

# 进行一次的流程操作
function testAPP() 
 { 
    echo "启动应用"
    sleep 3
    # 通过adb 启动应用
    # 参考 adb shell am (am为ActivityManager)
    # 参考 adb -s 为指定设备
    `(adb -s $deviceID shell am start -n com.clwater.test/clwater.test.StartActivity)`

    checkConnect

 } 


function start(){
    echo "开始测试"

    # while循环 一直执行某个流程的操作
    while True
    do
        echo "========================"
        time=$(date "+%Y/%m/%d %H:%M:%S")
        # 使得某个数字+1
        let startCount=($startCount + 1)
        echo "当执行时间: $time"
        echo "当执行次数: $startCount"

        testAPP
        
        echo ""
    done
}

# 开始
start


```
