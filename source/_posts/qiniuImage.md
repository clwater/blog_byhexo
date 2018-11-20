---
title: 七牛图床图片转移
date: 2018-11-19 21:39:03
tags: ["七牛" , "image" , "图床", "阿里OSS"]
categories: "想啥是啥"
---

# 七牛图床图片转移

>离职加四处浪的的我终于又开始工作了,还是浪的开心啊

>前两天整理博客的时候发现,存在七牛图床的图片...基本都挂了,想到了前段时间一直接受的七牛提示测试域名到期的事情...当我开始上班整理的时候发现,都挂了...辗转几天,把图片都转移到阿里OSS中.(关于七牛封测试域名的事情,一言难尽,用别人提供的方便,也别给别人带来麻烦不是.)

## 如何转移
转移的主要问题是当测试域名过期后,当前空间下的图片无法访问也无法预览.如果又一个备案过的域名倒是很容易解决,不过一般谁闲着没事去做公安的域名备案不是.只能通过七牛提供的qshell进行备份和转移.

<!-- more -->

## 转移步骤
1. 新建储存空间

  在七牛下创建一个新的储存空间,命名为**backup**(当然什么名字都好)
2. 操作qshell

  下载[qshell](https://developer.qiniu.com/kodo/tools/1302/qshell)(这个是七牛提供的shell工具)

  ```
  # AccessKey/SecretKey 需要在个人中心->密钥管理中查看,Name为当前需要备份的空间(我也不知道提供这个是个什么逻辑)
  ./qshell account [<AccessKey> <SecretKey> <Name>]
  # oldName为需要备份的空间名
  ./qshell_darwin_x64 listbucket <oldName> -o list.txt
  #获取所以文件名
  cat list.txt | awk -F '\t' '{print $1}' > list_final.txt
  # 将oldName空间中的文件转移到newName(backup)空间中
  ./qshell batchcopy <oldName> <newName> -i list_final.txt
  ```

3. 下载图片

  可以通过qshell中的qdownload方法来下载,不过并不在免费流量下载中,当然如果图片量比较小的话可以直接下载.

  如果图片量过大的话,可以查看[官方免流量配置文档](https://github.com/qiniu/qshell/blob/master/docs/qdownload.md).

## 重新上传
  因为平时使用的是极简图床,所以最后我使用的是阿里OSS.上传的方法也可以通过终端,或者直接网页中批量上传也可.

## 写在最后
  虽然平时的东西都比较水,最后还是希望找到点状态,多给自己留点东西.
