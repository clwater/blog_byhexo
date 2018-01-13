---
title: 在搬瓦工中搭建个人vpn(ss和pptp)
date: 2017-02-05 00:08:52
tags: ["vpn" , "搬瓦工" , "bandwagonhost" , "Shadowsocks" , "ss"]
categories: "教程"
---


> 帮助为了方便访问一些不存在的网站的你们

## 搬瓦工
[官方网站](http://bandwagonhost.com/) 虽然经常连接不上  反而这个[备用地址](http://bwh1.net)倒是连接速度很快
一个支持*ailpay*的国外vps 价格十分的感人 现在应该是2.99美元一个月 同时五个机房可以随意更换 也就是说可以获得五个ip地址 某些情况下十分的有用

同样价格感人的还有Host1plus 2美元每月 但是线路不是很稳定详细的可以查看[官方网站](https://www.host1plus.com/)

这里只是简单的介绍了两个可以通过支付宝支付的国外vps 免去了还得申请visa卡的纠结 更多详细的内容可以查看[十个便宜VPS(国内国外)主机分享-VPS服务器建站和搭建应用服务体验](https://zhuanlan.zhihu.com/p/21872685)
  <!-- more -->

## ss和pptp
ss就是Shadowsocks 一个轻量级的科学上网方式支持OS X Windows Linux iOS android的客户端. 具体可以参考[Shadowsocks的详细说明](https://zh.wikipedia.org/zh-cn/Shadowsocks)

pptp是一种点对点隧道协议 可以用来实现科学上网相对于ss来说可配置性更多. 具体的也可以参考[点对点隧道协议](https://zh.wikipedia.org/wiki/%E9%BB%9E%E5%B0%8D%E9%BB%9E%E9%9A%A7%E9%81%93%E5%8D%94%E8%AD%B0)


## 个人vpn搭建教程

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
![进入控制台](http://ooymoxvz4.bkt.clouddn.com/18-1-13/51872827.jpg)

2. 对系统进行更新
![对系统进行更新](http://ooymoxvz4.bkt.clouddn.com/18-1-13/4821245.jpg)

3. 一键生成ss服务

  ![一键生成ss服务](http://ooymoxvz4.bkt.clouddn.com/18-1-13/47291324.jpg)
  选择一键生成的功能

  ![成功生成](http://ooymoxvz4.bkt.clouddn.com/18-1-13/33245491.jpg)
  这个时候就说明生成成功了

  ![查看信息](http://ooymoxvz4.bkt.clouddn.com/18-1-13/3453713.jpg)
  ss服务的相关配置信息

  ![配置ss客户端](http://ooymoxvz4.bkt.clouddn.com/18-1-13/77964504.jpg)
  下载ss客户端后创建新的连接 输入相关的信息

  ![相关介绍](http://ooymoxvz4.bkt.clouddn.com/18-1-13/60933694.jpg)

  ![关闭ss](http://ooymoxvz4.bkt.clouddn.com/18-1-13/99019643.jpg)
  不需要的时候可以点击这里关闭ss服务

### 手动配置ss服务开启vpn

1. 进入控制台

2. 利用pip安装ss服务

  ```
  # yum install python-setuptools && easy_install pip  
  # pip install shadowsocks
  ```
3. 配置相关信息

  也有两种方式 推荐第一种 配置信息方便查看和更改
  *  创建配置信息
    ```
    # touch /etc/shadowsocks.json
    # vi /etc/shadowsocks.json

    {
    "server":"xxx.xxx.xxx", //服务器的IP
    "server_port":443,      //服务器断开
    "local_address": "127.0.0.1",   //客户端地址
    "local_port":1080,              //客户端端口
    "password":"MyPass",    //密码
    "timeout":600,          //超时时间(s)
    "method":"rc4-md5"      //加密方式 可选“bf-cfb”, “aes-256-cfb”, "salsa20" , “rc4″等
    }
    ```
    运行ss服务
    ```
    # ssserver -c /etc/shadowsocks.json -d start
    ```
  * 直接设置相关信息
    ```
    # ssserver -p 443 -k MyPass -m rc4-md5 -d start
    ```
4. 停止ss服务
  ```
  #ssserver -c /etc/shadowsocks.json -d stop
  //通过json文件配置开启的服务关闭方法

  #ssserver -d stop
  //直接配置信息开启的服务关闭的方法
  ```

## 通过pptp搭建个人vpn
1. 安装PPP和iptables
  ```
  # yum install -y ppp iptables
  ```
2. 安装pptpd
  由于我们是通过yum安转的ppp 因为yum安转的ppp是最新的版本 所以我们要根据当前的ppp版本来选择pptp的版本
  ```
  # yum list installed ppp  //查看当前ppp版本
  ```
  ![查看当前ppp版本](http://ooymoxvz4.bkt.clouddn.com/18-1-13/34188869.jpg)

  根据当期ppp版本选择对应的pptp版本 可以在[这里](http://poptop.sourceforge.net/yum/stable/packages/)找到对应的版本下载

  ppp 2.4.4 对应 pptp 1.3.4的版本

  ppp 2.4.5 对应 pptp 1.4.0的版本

  ```
  # wget http://poptop.sourceforge.net/yum/stable/packages/pptpd-1.4.0-1.el6.x86_64.rpm
  //下载对应的版本
  # yum install perl
  //安装perl
  # rpm -ivh pptpd-1.4.0-1.el6.x86_64.rpm
  //安装pptp
  ```

  至此均安装完毕 下面进行配置

3. vpn相关配置
  一下均对配置文件进行备份 有需要的可以回滚操作

  * 配置 /etc/ppp/options.pptpd

  ```
  # cp /etc/ppp/options.pptpd /etc/ppp/options.pptpd.bak
  //备份
  # vi /etc/ppp/options.pptpd

  //将以下内容添加到options.pptpd当中
  ms-dns 8.8.8.8
  ms-dns 8.8.4.4
  ```
  * 配置 /etc/ppp/chap-secrets

  ```
  # cp /etc/ppp/chap-secrets   /etc/ppp/chap-secrets.bak
  //备份
  # vi /etc/ppp/chap-secrets

  //添加以下内容
  myusername pptpd mypassword *
  //myusername vpn账号
  //mypassword vpn密码
  //* 可连接的ip地址 *表示接受所有ip地址的来源
  ```
  * 配置 /etc/pptpd.conf

  ```
  # cp /etc/pptpd.conf     /etc/pptpd.conf.bak
  //备份
  # vi /etc/pptpd.conf

  //添加一下内容 用于获得vpn客户端获得ip的范围
  localip 192.168.0.1
  remoteip 192.168.0.234-238,192.168.0.245

  //配置文件的最后要以空行结尾
  ```

  * 配置 /etc/sysctl.conf

  ```
  # cp /etc/sysctl.conf /etc/sysctl.conf.bak
  # vi /etc/sysctl.conf

  //修改以下内容 使其支持转发
  net.ipv4.ip_forward = 1

  # /sbin/sysctl -p
  //保存修改后的文件
  ```

  * 启动pptp服务和iptables

  ```
  # /sbin/service iptables start
  //启动iptables

  # iptables -t nat -A POSTROUTING -o eth0 -s 192.168.0.0/24 -j SNAT --to-source xxx.xxx.xxx.xxx
  //设置转发功能 -o eth0制定网卡
  // xxx.xxx.xxx.xxx为公网ip

  # /etc/init.d/iptables save
  //保存iptables的转发规则
  # /sbin/service iptables restart
  //重新启动iptables

  # service pptpd start
  ```

## FinalSpeed对ss的优化提速
```
# wget http://fs.d1sm.net/finalspeed/install_fs.sh
# chmod +x install_fs.sh
# ./install_fs.sh 2>&1 | tee install.log
```


## 相关注意事项
**个人学习用 不要用于奇怪的地方 游戏延迟可能很高**
