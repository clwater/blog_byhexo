---
title: 如何在SpeedDialPlus中使用EarthViewfromGoogleEarth图片作为背景
date: 2017-05-17 23:56:45
tags: ["peed Dial Plus" , "Earth View from Google Earth" , "Chrome插件" , "Python"]
categories: "Python"
---

## 如何在SpeedDialPlus中使用EarthViewfromGoogleEarth图片作为背景

## 介绍
Speed Dial Plus和Earth View from Google Earth都是Chrome中的两个十分好用的新标签页插件

Speed Dial Plus可以在你打开一个新的标签页的时候提供经常访问的页面的快捷方式 虽然还有很多扩展, 但是这个功能真心好用
![Speed Dial Plus](http://ooymoxvz4.bkt.clouddn.com/17-5-18/39416953-file_1495036928867_860e.png)
<!--more-->
Earth View from Google Earth可以在你打开一个新的标签页的时候展示一副google earth拍摄的图片(虽然只有1500多个图片 但是每幅图都是十分别致的)
![Earth View from Google Earth](http://ooymoxvz4.bkt.clouddn.com/17-5-18/62579920-file_1495037085098_d853.png)


## 需求
这两个都是十分优秀的标签页的工具,那么问题就是 这两个不能共同使用 虽然SDP提供了设置背景页面的方法,但是每次只能设置成一个页面

## 解决思路
通过分析Earth View from Google Earth来获取所有图片的地址 再在本地或者自己的服务器中部署一个服务器 可以随机返回有效图片地址中的一个 再将SDP中设置背景为自己的服务器设定的地址

最终实现打开新标签页(SDP) SDP访问你的服务地址 服务随机返回一个图片地址 SDP最终访问你设定的新的图片地址

## 分析Earth View from Google Earth
本来是打算直接使用Chrome的开发者工具和charles直接分析网络请求，但是每次返回的图片地址都不一样只能进一步查看GoogelEarth的页面了
如https://g.co/ev/2131 这样的短链，可以看到后面的2131这样的四位id 尝试了几次发现不是连续的。  本来打算写个脚本 验证下一定范围内哪些数字是有效的
然后日常github 发现了[这个好东西](https://github.com/limhenry/earthview) 提供了一个一个[接口](https://raw.githubusercontent.com/limhenry/earthview/master/earthview.json)可以得到当前所有图片的信息
![所有图片的信息](http://ooymoxvz4.bkt.clouddn.com/17-5-18/11845916-file_1495088848235_6c3c.png)

可以通过这个json数据解析出所有的图片id  保存到本地作为服务器的数据源

## 具体实现
```Python

import requests
import random, re , threading , time , socket
import tornado.web
import tornado.ioloop

allindex = 0

def getUrl():
    #通过随机得到的位置来得到对应位置的
    id = randomid()
    with open('date', 'r') as f:
        _image = f.read()

    _imagelist = _image.split(',')
    _imagelist.pop()
    return _imagelist[id]


def updateindex():
  #更新所有图片数量的数据
    global  allindex
    with open('daterand', 'r') as f:
        allindex = f.read()

def getAllDate():
  #从提供的接口中获取所有图片的id并保存下来 同时设置延时每天更新下数据
    print('getAllDate')
    reponse = requests.get('https://raw.githubusercontent.com/limhenry/earthview/master/earthview.json')
    html = reponse.text

    with open('date', 'w') as f:
        imageList = re.findall('"image":".*?"' , html)
        for image in imageList:
            imageurl = re.findall('[0-9]{4,5}' ,image)
            f.write(imageurl[0] + ',')

    with open('daterand', 'w') as f:
        f.write(str(len(imageList)))

    updateindex()

    time.sleep(60 * 60 * 24)
    getAllDate()


def randomid():
  #随机数什么的
    global allindex
    _allindex = int(allindex)
    id = random.randint(0, _allindex)
    return id


class earthImage(tornado.web.RequestHandler):
    def get(self, *args, **kwargs):
        _id = getUrl()
        imageurl = 'http://www.gstatic.com/prettyearth/assets/full/%s.jpg'%(_id)
        print(imageurl)
        #直接指向随机图片的地址
        self.redirect(imageurl)

application = tornado.web.Application([
    (r"/earthImage" , earthImage)
])

def runServer():
  #trnado 服务器的配置 我这里在运行之后会显示当前的地址
    port = 9011
    application.listen(port)
    localIP = socket.gethostbyname(socket.gethostname())
    print("run in %s:%s"%(localIP,port))
    tornado.ioloop.IOLoop.instance().start()

def startServer():
    print('startServer')
    runServer()

def main():
    //这里开了两个线程 防止取得图片数据的时候访问阻塞
    updateindex()
    thread_getInfoDate = threading.Thread(target=getAllDate, name='getAllDate')
    thread_startServer = threading.Thread(target=startServer, name='startServer')

    thread_getInfoDate.start()
    thread_startServer.start()
main()
```

最后打开SpeedDialPlus的设置 更改其中主题里的自定义网址为你服务器运行后的地址就好了 当然 也可以部署在云服务器中

## 改进
程序写的很随意 山顶洞人编程 性能的话自用还可以的

图片的话只有google erath的图片 可以配置或加入更多的图片 现阶段基本没有扩展性 只能看地球了(1500多张图片还不够看 只能说明 该换风格了)

## 项目地址

https://github.com/clwater/SpeedDialPlusImage
