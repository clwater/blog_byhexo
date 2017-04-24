---
title: Hexo安装后hexo指令无法被找到的解决方法
date: 2017-04-23 14:05:36
tags: ["hexo" , "command not found"]
categories: "Hexo"
---

>[Hexo](https://hexo.io/) 是一个十分便捷的博客搭建工具 但是经常会遇见安装完成后再次打开终端操作的时候提示 command not found: hexo的情况 对应的github的issues中也没有详细的解决办法在这提供一种可行的解决思路 希望能帮助到大家
<!-- more -->

*相关的环境在mac下 部分终端指令在linux下可能有所不同*

Hexo安装后 `command not found: hexo`的解决方法

出现这种情况主要是node的版本问题 可以通过nvm来控制一下node的版本来解决

## nvm的安装

nvm是nodejs的版本控制工具,可以很轻松来控制node的版本

下面推荐两个安装方法,可以根据实际情况进行处理

1. 通过brew进行安装

```
  brew install nvm
  //这个过程中可能需要安装gcc或者其它需要依赖的工具 按照提示一次安装好即可
  mkdir ~/.nvm
  export NVM_DIR=~/.nvm
  .$(brew --prefix nvm)/nvm.sh
  //这个步骤中mac下的brew需要通过--prefix这种形式完成
```
2. 通过curl进行安装
```
 curl https://raw.github.com/creationix/nvm/master/install.sh | sh
```
通过curl安装需要重启终端

3. 可能出现的问题  command not found: nvm
确定以上正确执行过以上两个方法之一后 可能会遇到这种问题 需要你手动添加相关的环境变量
编辑 ~/.bash_profile文件 如果使用zsh(iterm)的话是 ~/.zshrc
将以下内容添加到bash_profile或zshrc文件中
```
  export NVM_DIR="/Users/yourcomptername/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
```
yourcomptername的位置要填你自己的路径

## 安装hexo等
```
  nvm install 4 (此处的版本可以根据实际情况处理)
  //确保以上都完成后再安装hexo
  sudo npm install hexo-cli -g
```

至此应该可以在终端中输入hexo来验证一下是否安装成功

然后就可以重启终端了 再次输入hexo后会出现 command not found: hexo的提示  一般情况下都是首次安装hexo后可以正常使用 后来再次使用的时候发现无法使用

## 正文开始
也不能说是正文 之前的都是为所依赖的环境做准备 顺便简单排除一下其它因素

**查看node的版本情况**

![查看node的版本情况](http://i1.piimg.com/567571/40394f9488d8e335.png)
(这个截图是我配置完成后的截图 初次使用的时候可能有部分出入)

在这里可以看到我的node版本是4.8.2

再进行一下的操作
```
  //切换对应的版本
  nvm use 4.8.2

  //但是每次重启终端后改设置都会失效 所以要设置默认的版本
  nvm alias default 4.8.2
```
再次使用nvm ls命令来查看 当和前面的途中绿色箭头指向你所指定的版本好的时候就说明设置成功了

至此应该可以解决command not found: hexo的问题了

如果还是不可以 可以尝试通过 `sudo npm install hexo-cli -g` 重装一下hexo
