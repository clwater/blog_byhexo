---
title: 在搬瓦工中搭建个人vpn(ss和pptp)
date: 2017-02-05 00:08:52
tags: ["vpn" , "搬瓦工" , "bandwagonhost" , "Shadowsocks" , "ss"]
categories: "教程"
---


> 帮助为了方便访问一些不存在的网站的你们

### 搬瓦工
[官方网站](http://bandwagonhost.com/) 虽然经常连接不上  反而这个[备用地址](bwh1.net)倒是连接速度很快
一个支持*ailpay*的国外vps 价格十分的感人 现在应该是2.99美元一个月 同时五个机房可以随意更换 也就是说可以获得五个ip地址 某些情况下十分的有用

同样价格感人的还有Host1plus 2美元每月 但是线路不是很稳定详细的可以查看[官方网站](https://www.host1plus.com/)

这里只是简单的介绍了两个可以通过支付宝支付的国外vps 免去了还得申请visa卡的纠结 更多详细的内容可以查看[十个便宜VPS(国内国外)主机分享-VPS服务器建站和搭建应用服务体验](https://zhuanlan.zhihu.com/p/21872685)
  <!-- more -->

## ss和pptp
ss就是Shadowsocks 一个轻量级的科学上网方式支持OS X Windows Linux iOS android的客户端. 具体可以参考[Shadowsocks的详细说明](https://zh.wikipedia.org/zh-cn/Shadowsocks)

pptp是一种点对点隧道协议 可以用来实现科学上网相对于ss来说可配置性更多. 具体的也可以参考[点对点隧道协议](https://zh.wikipedia.org/wiki/%E9%BB%9E%E5%B0%8D%E9%BB%9E%E9%9A%A7%E9%81%93%E5%8D%94%E8%AD%B0)

# 个人vpn搭建教程

## vps的准备
由于是在搬瓦工中搭建的vpn 所以还是推荐购买搬瓦工的服务器 需要注意以下几点
1. 注册的邮箱需要真实 省的以后无法找回密码
2. 同样是注册时 用拼音填写就可以 资料是否真实无所谓 但是国家 省份需要真实存在的
3. 购买的时候选择价格最低的就好 国外的服务器一般都是用来搭建这个的不是 500g额度也够你使用了 可以根据自己的情况选择购买的方式 一月 一季度 半年和一年的四种方式 时间越长每月的花销越低 看个人的选择
4. 玄学是洛杉矶的机房的网速最快
5. 搬瓦工的对文本的操作是会在额外的弹窗中进行的 注意不要阻止弹出 要不你会因为奇怪的提示而怀疑人生的


## 通过ss搭建个人vpn
搬瓦工有一键开启ss的功能 只是想简单的自己做个vpn没有额外其他的要求可以使用一下 十分的便捷 同样 我也会说一下手动配置的方法 也十分的便捷其实
### 利用ss的Shadowsocks Server一键开启vpn
1. 进入控制台
![进入控制台](http://i1.piimg.com/567571/da396ac2d05d73d7.png)

2. 对系统进行更新
![对系统进行更新](http://p1.bpimg.com/567571/417fc58c53547be2.png)

3. 一键生成ss服务

  ![一键生成ss服务](http://p1.bpimg.com/567571/71c870fbe1035250.png)
  选择一键生成的功能

  ![成功生成](http://p1.bpimg.com/567571/a28aca97428d8192.png)
  这个时候就说明生成成功了

  ![查看信息](http://i1.piimg.com/567571/f16a5cf8480ded88.png)
  ss服务的相关配置信息

  ![配置ss客户端](http://i1.piimg.com/567571/8c1dbd24a590d38b.png)
  下载ss客户端后创建新的连接 输入相关的信息

  ![相关介绍](http://p1.bpimg.com/567571/a003df1753b524ae.png)

  ![关闭ss](http://p1.bpimg.com/567571/db9a818fc6d290bd.png)
  不需要的时候可以点击这里关闭ss服务

  ---
  待续
