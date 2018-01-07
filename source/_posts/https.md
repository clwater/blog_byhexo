---
title: Https从了解到算了
date: 2017-11-04 22:52:03
tags: ["https" ]
categories: "https"
---

# Https从了解到算了


## Https的概念

*以下相关名词均摘自wikipedia*

**Https** 超文本传输安全协议（英语：Hypertext Transfer Protocol Secure，缩写：HTTPS，常称为HTTP over TLS，HTTP over SSL或HTTP Secure）是一种通过计算机网络进行安全通信的传输协议。HTTPS经由HTTP进行通信，但利用SSL/TLS来加密数据包。HTTPS开发的主要目的，是提供对网站服务器的身份认证，保护交换数据的隐私与完整性。这个协议由网景公司（Netscape）在1994年首次提出，随后扩展到互联网上。

  <!-- more -->

**SSL** 安全套接层（Secure Sockets Layer）是netscape设计的主要用于Web的安全传输协议,位于可靠的面向连接的网络层协议和应用层协议之间的一种协议层。

**TLS** 传输层安全协议（英语：Transport Layer Security） 用于两个应用程序之间提供保密性和数据完整性。

**IETF** 互联网工程任务小组（英语：Internet Engineering Task Force，縮寫為IETF）负责互联网标准的开发和推动。

### TLS与SSL关系

TLS的前身是 SSL3.0 协议，最早由netscape公司于 1995 年发布，1999 年经过 IETF 讨论和规范后，改名为 TLS。如果没有特别说明，SSL 和 TLS 说的都是同一个协议。

目前有以下几个版本：SSLv2，SSLv3，TLSv1，TLSv1.1，TLSv1.2，TLSv1.3(草案)当前基本不再使用低于 TLSv1 的版本

### Https与Http
![Https与Http](http://upload-images.jianshu.io/upload_images/2191286-e6c903c097325fbd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## TLS/SSL协议的基本概念

TLS/SSL的功能实现主要依赖于三类基本算法：散列函数 Hash、对称加密和非对称加密，其利用非对称加密实现身份认证和密钥协商，对称加密算法采用协商的密钥对数据加密，基于散列函数验证信息的完整性

* **散列函数Hash**：常见的有 MD5、SHA1、SHA256，该类函数特点是函数单向不可逆、对输入非常敏感、输出长度固定，针对数据的任何修改都会改变散列函数的结果，用于防止信息篡改并验证数据的完整性；

* **对称加密**：常见的有 AES-CBC、DES、3DES、AES-GCM等，相同的密钥可以用于信息的加密和解密，掌握密钥才能获取信息，能够防止信息窃听，通信方式是1对1；

* **非对称加密**：即常见的 RSA、ECDHE、DH 、DHE等算法，算法特点是，密钥成对出现，一般称为公钥(公开)和私钥(保密)，公钥加密的信息只能私钥解开，私钥加密的信息只能公钥解开。因此掌握公钥的不同客户端之间不能互相解密信息，只能和掌握私钥的服务器进行加密通信，服务器可以实现1对多的通信，客户端也可以用来验证掌握私钥的服务器身份。

![ TLS/SSL协议的基本概念](http://upload-images.jianshu.io/upload_images/2191286-37ce3cd16de5b2fe.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 对称加密的弊端

1. 要求提供一条安全的通道使通信双方在首次通信时协商一个共同的密钥。直接面对面协商可能难于实施，所以双方需要借助于邮件和电话等其他相对不够安全的手段来进行协商。

2. 密钥的数目难于管理。因为对于每一个合作者都需要使用不同的密钥，很难适应开放社 会中大量的信息交流。
对称加密算法一般不能提供信息完整性的鉴别。它无法验证发送者和接受者的身份。

3. 对称密钥的管理和分发工作是一件具有潜在危险的、繁琐的过程。对称加密是基于共同保守秘密来实现的，采用对称加密技术的贸易双方必须保证采用的是相同的密钥，保证彼此密钥的交换是安全可靠的，同时还要设定防止密匍泄密和更改密钥的程序。

### 非对称加密的弊端

#### 先天不足

在公开密钥密码体制中，常用的一种是RSA加密算法。其数学原理是将一个大数分解成两个质数的乘积，加密和解密用的是两个不同的密钥。即使己知明文、密文和加密密钥(公钥)，想要推导出解密密钥(私钥)，在计算上是不可能的。按现在的计算机技术水平，要破解目前采用的1024位RSA密钥，需要上千年的计算时间。公开密钥技术解决了密钥发布的管理问题，商家可以公开其公开密钥，而保留其私有密钥。在2010年以后，均采用了2048位的签名

身份验证和密钥协商是TLS的基础功能，要求的前提是合法的服务器掌握着对应的私钥。但RSA算法无法确保服务器身份的合法性，因为公钥并不包含服务器的信息

#### 中间人攻击和信息抵赖

![中间人攻击和信息抵赖](http://upload-images.jianshu.io/upload_images/2191286-a020141dd8dbef6f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

1. 客户端C和服务器S进行通信，中间节点M截获了二者的通信；
2. 节点M自己计算产生一对公钥pub_M和私钥pri_M；
3. C向S请求公钥时，M把自己的公钥pub_M发给了C；
4. C使用公钥 pub_M加密的数据能够被M解密，因为M掌握对应的私钥pri_M，而 C无法根据公钥信息判断服务器的身份，从而 C和 M之间建立了"可信"加密连接；
5. 中间节点 M和服务器S之间再建立合法的连接，因此 C和 S之间通信被M完全掌握，M可以进行信息的窃听、篡改等操作。

6. 服务器也可以对自己的发出的信息进行否认，不承认相关信息是自己发出。

## 横空出世的CA验证及证书

CA （Certification Authority）负责审核信息，然后对关键信息利用私钥进行"签名"，公开对应的公钥，客户端可以利用公钥验证签名。CA也可以吊销已经签发的证书，具体的流程如下：

![CA验证及证书](http://upload-images.jianshu.io/upload_images/2191286-0bd0b5431c947a71.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 相关

1. 申请证书不需要提供私钥，确保私钥永远只能服务器掌握；
2. 证书的合法性仍然依赖于非对称加密算法，证书主要是增加了服务器信息以及签名；
3. 内置 CA 对应的证书称为根证书，颁发者和使用者相同，自己为自己签名，即自签名证书；
4. 证书=公钥+申请者与颁发者信息+签名；
5. 公钥放在数字证书中。只要证书是可信的，公钥就是可信的。


## 如何验证证书的合法性

客户端针对服务端用私钥对证书信息签名的校验

当客户端对服务端发送client_hello之后 服务端会将公开的密钥证书发送给客户端,证书中包含了**公钥**,**各种信息**,**签名**(ca针对证书的摘要信息进行私钥加密)

当客户端接收到证书后会通过内置ca公钥对签名进行解密已验证证书的合法性.如果已知的ca公钥均无法解密证书签名,则认定当前证书不是被认可的证书(没有颁布本证书或者证书被伪造)


## 证书链

**证书链** :服务器证书、中间证书与根证书在一起组合成一条合法的证书链，证书链的验证是自下而上的信任传递的过程。

如 CA根证书和服务器证书中间增加一级证书机构，即中间证书，证书的产生和验证原理不变，只是增加一层验证，只要最后能够被任何信任的CA根证书验证合法即可。

1. 服务器证书 server.pem 的签发者为中间证书机构 inter，inter 根据证书 inter.pem 验证 server.pem 确实为自己签发的有效证书；
2. 中间证书 inter.pem 的签发 CA 为 root，root 根据证书 root.pem 验证 inter.pem 为自己签发的合法证书；
3. 客户端内置信任 CA 的 root.pem 证书，因此服务器证书 server.pem 的被信任。

![证书链](http://upload-images.jianshu.io/upload_images/2191286-a2f32046f8d49e23.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


###  证书链的优势与特点
* 减少根证书结构的管理工作量，可以更高效的进行证书的审核与签发；
* 根证书一般内置在客户端中，私钥一般离线存储，一旦私钥泄露，则吊销过程非常困难，无法及时补救；
* 中间证书结构的私钥泄露，则可以快速在线吊销，并重新为用户签发新的证书；
* 证书链四级以内一般不会对 HTTPS 的性能造成明显影响。
* 同一本服务器证书可能存在多条合法的证书链。因为证书的生成和验证基础是公钥和私钥对，如果采用相同的公钥和私钥生成不同的中间证书，针对被签发者而言，该签发机构都是合法的 CA，不同的是中间证书的签发机构不同；
* 不同证书链的层级不一定相同，可能二级、三级或四级证书链。中间证书的签发机构可能是根证书机构也可能是另一个中间证书机构，所以证书链层级不一定相同。

![证书链的优势与特点](http://upload-images.jianshu.io/upload_images/2191286-5b6f0a2d6b27c56e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 证书吊销

CA 机构能够签发证书，同样也存在机制宣布以往签发的证书无效。证书使用者不合法，CA 需要废弃该证书；或者私钥丢失，使用者申请让证书无效。主要存在两类机制：CRL与OCSP。

### CRL

Certificate Revocation List， 证书吊销列表，是一个单独的文件。该文件包含了 CA 已经吊销的证书序列号(唯一)与吊销日期，同时该文件包含生效日期并通知下次更新该文件的时间，当然该文件必然包含 CA 私钥的签名以验证文件的合法性。

在证书中一般会包含一个 URL 地址 CRL Distribution Point，通知使用者去哪里下载对应的 CRL 以校验证书是否吊销。该吊销方式的优点是不需要频繁更新，但是不能及时吊销证书，因为 CRL 更新时间一般是几天，这期间可能已经造成了极大损失。

### OCSP

Online Certificate Status Protocol， 证书状态在线查询协议，一个实时查询证书是否吊销的方式。请求者发送证书的信息并请求查询，服务器返回正常、吊销或未知中的任何一个状态。

证书中一般也会包含一个 OCSP 的 URL 地址，要求查询服务器具有良好的性能。部分 CA 或大部分的自签 CA (根证书)都是未提供 CRL 或 OCSP 地址的，对于吊销证书会是一件非常麻烦的事情。


## TLS/SSL握手过程

### X.509
X.509 是一个标准，也是一个数字文档，这个文档根据RFC 5280来编码并签发，一份X.509证书是一些标准字段的集合，这些字段包含有关用户或设备及其相应公钥的信息。

### 编码 (也用于扩展名)
* .DER - 扩展名DER用于二进制DER编码的证书，不可读。这些证书也可以用CER或者CRT作为扩展名。 Java和Windows服务器偏向于使用这种编码格式，比较合适的说法是“我有一个DER编码的证书”，而不是“我有一个DER证书”。

* .PEM - 扩展名PEM用于ASCII(Base64)编码的各种X.509 v3 证书。以“-----BEGIN...”开头， “-----END...”结尾，内容是BASE64编码，Apache和Linux服务器偏向于使用这种编码格式。

### 常用的扩展名
* .KEY - 通常用来存放一个公钥或者私钥，并非X.509证书，编码可能是PEM，也可能是DER.

* .CSR - 是Certificate Signing Request的缩写，即证书签名请求，这不是证书，是生成证书时要把这个提交给权威的证书颁发机构。其核心内容是一个公钥(当然还附带了一些别的信息)，在生成这个申请的时候，同时也会生成一个私钥，私钥要自己保管好.当权威证书颁发机构颁发的证书过期的时候，你还可以用同样的csr来申请新的证书，key保持不变.

* .CRT - certificate的缩写，其实还是证书的意思，常见于Linux系统，有可能是PEM或者DER编码，大多数应该是PEM编码.

* .CER - certificate的缩写，其实还是证书的意思，常见于Windows系统，有可能是PEM或者DER编码，大多数应该是DER编码.

注意：CRT文件和CER文件只有在使用相同编码的时候才可以安全地相互替代。

* .PFX/PKCS12 - predecessor of PKCS#12，包含了证书和私钥，对Linux服务器来说，一般来说CRT和KEY是分开存放在不同文件中的，但Windows的IIS则将它们存在一个PFX文件中，并通过提取密码来保护。

* .JKS/JCEKS - Java密钥库(KeyStore)的两种比较常见类型，包含了证书和私钥，利用Java的“keytool”的工具，可以将PFX转为JKS，当然了，keytool也能直接生成JKS，JCEKS在安全级别上要比JKS强，使用的Provider是JCEKS(推荐)，使用使用TripleDES 保护KeyStore中的私钥；

* .BKS – Bouncy Castle Provider，包含了证书和私钥， android系统支持的类型，它使用的也是TripleDES来保护密钥库中的私钥，它能够防止证书库被不小心修改（Keystore的keyentry改掉1个bit都会产生错误），BKS能够跟JKS互操作。

注意：通过工具 BKS、JKS、PFX 三种格式的证书均可以相互转换

### OpenSSL
OpenSSL简单地说，OpenSSL是SSL的一个实现，SSL只是一种规范理论上来说，SSL这种规范是安全的，目前的技术水平很难破解，但SSL的实现就可能有些漏洞，如著名的“心脏出血”。OpenSSL还提供了一大堆强大的工具软件，强大到90%我们都用不到.

### 证书编码的转换
PEM转为DER openssl x509 -in cert.crt -outform der -out cert.der
DER转为PEM openssl x509 -in cert.crt -inform der -outform pem -out cert.pem
(提示:要转换KEY文件也类似，只不过把x509换成rsa，要转CSR的话，把x509换成req...)

### "心脏出血"事件

2014年曝光了OpenSSL的源代码中存在一个漏洞，可以让攻击者获得服务器上64K内存中的数据内容

OpenSSL心脏出血漏洞的大概原理是OpenSSL在2012年引入了心跳(heartbeat)机制来维持TLS链接的长期存在，心跳机制是作为TLS的扩展实现，但在代码中包括TLS(TCP)和DTLS(UDP)都没有做边界的检测，所以导致攻击者可以利用这个漏洞来获得TLS链接对端（可以是服务器，也可以是客户端）内存中的一些数据，至少可以获得16KB每次，理论上讲最大可以获取64KB。

Alexa排名前百万的网站中有40.9%的网站收到影响

## Https主要流程
|client|server|
|-|-|
|1 Client Hello||
||2 Server Hello|
||3 certificate|
||4 server_key_exchange(DH加密需要)|
|| *5 certificate_request(双向验证需要)*|
||6 server_hello_done|
|*7 certificate(双向验证需要)*||
|8 client_key_exchange  ||
|*9 certifiate_verify(双向验证需要)*||
|10 change_cypher_spec||
|11 encrypted handshake message||
|----finished----| |
||12 change_cypher_spec|
||13 encrypted handshake message|
||----finished----|

![Https主要流程](http://upload-images.jianshu.io/upload_images/2191286-e1df3220da857387.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Wireshark抓包实例

![Wireshark抓包实例](http://upload-images.jianshu.io/upload_images/2191286-e8e05fc281b9537d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
1. Client Hello (C-S)
![Client Hello (C-S)](http://ooymoxvz4.bkt.clouddn.com/17-11-3/93935647.jpg)

  1. 提供最高支持的TLS/SSl版本
  2. 客户端生成随机数random_c
  3. 客户端支持的加密方式

2. Server Hello(S-C)
![Server Hello(S-C)](http://upload-images.jianshu.io/upload_images/2191286-7563d4329f2aed04.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  1. 协商后使用的TLS/SSl版本
  2. 服务端生成随机数random_s
  3. 协商后使用的加密方式

   (上图中使用的是RSA和DH混合使用的方式,RSA验证服务器身份,DH算法加密密钥)

3. Certificate (S-C)/可选
![Certificate (S-C)/可选](http://upload-images.jianshu.io/upload_images/2191286-4bf6023a012fb63b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  提供服务器的身份证书给客户端鉴定，如果不用公钥证书体系验证身份和交换密钥，该步骤可选，比如在用DH方法交换的时候。

4. Server Key Exchange (S-C)/可选
![Server Key Exchange/Server Hello Done ](http://upload-images.jianshu.io/upload_images/2191286-eb38c906b7320390.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  密钥交换用到的服务器方的信息，一般是补充上次的 [Certificate]指令的信息，如果才用DH加密算算法需要提供.

5. certificate_request(S-C)/可选
  服务端要求客户端提供证书,包括客户端可以提供的证书类型及服务器接受的证书distinguished name列表，可以是root CA或者subordinate CA

6. Server Hello Done (S-C)
![Server Key Exchange/Server Hello Done ](http://upload-images.jianshu.io/upload_images/2191286-f8850135af6799bf.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  结束服务器端的握手过程

7. certificate(C-S)/可选
  如果服务端需要客户端提供证书,则在此提供客户端的证书

8. Client Key Exchange (C-S)
![Client Key Exchange](http://upload-images.jianshu.io/upload_images/2191286-f70ac54dcd9e6c1e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  客户端会在生成一个随机数pubkey并将它发送到服务端,客户端与服务端均会根据之前生成的random_c,random_s,pubkey三个随机数生成对称加密的session secret
9. certifiate_verify(C-S)/可选
  发送使用客户端证书给到这一步为止收到和发送的所有握手消息签名结果

10. Change Cipher Spec (C-S)
![Change Cipher Spec (C-S)](http://upload-images.jianshu.io/upload_images/2191286-7f3194d187d94ea9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  通知服务端接下来的数据均采用session secret为key对称加密方式

11. Encrypted Handshake Message(C-S)
![Encrypted Handshake Message(C-S)](http://upload-images.jianshu.io/upload_images/2191286-ba2ea86dc66b772e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  客户端随后立刻发送了一个经过加密的消息, 服务端应该可以根据生成的session secret来进行解密,这个加密的消息解密以后是有固定格式的，符合这个格式，或则满足一些字符匹配，才是合法的。

12. Change Cipher Spec(S-C)
![Change Cipher Spec(S-C)](http://upload-images.jianshu.io/upload_images/2191286-8e208fbef4d4f2ce.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  通知客户端接下来的数据均采用被session secret加密的对称加密方式

13. Encrypted Handshake Message(S-C)
![Change Cipher Spec(S-C)](http://upload-images.jianshu.io/upload_images/2191286-d3bb751cd551332e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  服务端随后也立刻发送了一个经过加密的消息,让给客户端进行验证

14. 正式的数据交互
  随后两端都会通过已经协商好的session secret作为key的对称加密方式通过http协议进行数据交互


## 自签名证书的不安全性

1. 自签证书最容易被假冒和伪造，而被欺诈网站所利用
* 自签证书最容易受到SSL中间人攻击
* 以上这两点都是由于自签证书不受浏览器信任，而网站告诉用户要信任而造成
* 自签证书支持不安全的SSL通信重新协商机制(Dos及中间人攻击)
* 自签证书支持非常不安全的SSL V2.0协议
* 自签证书没有可访问的吊销列表
* 自签证书使用1024位的非对称密钥对
* 自签证书证书有效期太长，短则5年，长则20年、30年

## HTTPS性能损耗

### 增加延时

分析前面的握手过程，一次完整的握手至少需要两端依次来回两次通信，至少增加延时2*RTT（Round-Trip Time，往返时间），利用会话缓存从而复用连接，延时也至少1* RTT。

### 消耗较多的CPU资源

除数据传输之外，HTTPS通信主要包括对对称加解密、非对称加解密(服务器主要采用私钥解密数据)；压测 TS8 机型的单核 CPU：对称加密算法AES-CBC-256 吞吐量 600Mbps，非对称 RSA 私钥解密200次/s。不考虑其它软件层面的开销，10G 网卡为对称加密需要消耗 CPU 约17核，24核CPU最多接入 HTTPS 连接 4800；
静态节点当前10G 网卡的 TS8 机型的 HTTP 单机接入能力约为10w/s，如果将所有的HTTP连接变为HTTPS连接，则明显RSA的解密最先成为瓶颈。因此，RSA的解密能力是当前困扰HTTPS接入的主要难题。

## HTTPS接入优化

### CDN接入
HTTPS 增加的延时主要是传输延时 RTT，RTT 的特点是节点越近延时越小，CDN 天然离用户最近，因此选择使用 CDN 作为 HTTPS 接入的入口，将能够极大减少接入延时。CDN 节点通过和业务服务器维持长连接、会话复用和链路质量优化等可控方法，极大减少 HTTPS 带来的延时。
### 会话缓存
虽然前文提到 HTTPS 即使采用会话缓存也要至少1*RTT的延时，但是至少延时已经减少为原来的一半，明显的延时优化；同时，基于会话缓存建立的 HTTPS 连接不需要服务器使用RSA私钥解密获取 Pre-master 信息，可以省去CPU 的消耗。如果业务访问连接集中，缓存命中率高，则HTTPS的接入能力讲明显提升。当前TRP平台的缓存命中率高峰时期大于30%，10k/s的接入资源实际可以承载13k/的接入，收效非常可观。
### 硬件加速
为接入服务器安装专用的SSL硬件加速卡，作用类似 GPU，释放 CPU，能够具有更高的 HTTPS 接入能力且不影响业务程序的。测试某硬件加速卡单卡可以提供35k的解密能力，相当于175核 CPU，至少相当于7台24核的服务器，考虑到接入服务器其它程序的开销，一张硬件卡可以实现接近10台服务器的接入能力。
### 远程解密
本地接入消耗过多的 CPU 资源，浪费了网卡和硬盘等资源，考虑将最消耗 CPU 资源的RSA解密计算任务转移到其它服务器，如此则可以充分发挥服务器的接入能力，充分利用带宽与网卡资源。远程解密服务器可以选择 CPU 负载较低的机器充当，实现机器资源复用，也可以是专门优化的高计算性能的服务器。当前也是 CDN 用于大规模HTTPS接入的解决方案之一。
### SPDY/HTTP2
前面的方法分别从减少传输延时和单机负载的方法提高 HTTPS 接入性能，但是方法都基于不改变 HTTP 协议的基础上提出的优化方法，SPDY/HTTP2 利用 TLS/SSL 带来的优势，通过修改协议的方法来提升 HTTPS 的性能，提高下载速度等。


## 参考文章
[图解SSL/TLS协议](http://blog.csdn.net/fw0124/article/details/40875629)

[SSL/TLS 握手优化详解
](http://blog.jobbole.com/94332/)

[大型网站的 HTTPS 实践（1）：HTTPS 协议和原理](http://blog.jobbole.com/86660/)


[沃通（Wosign）关于数字证书的技术文档](http://www.wosign.com/faq/index_1.htm)

[HTTPS通信建立过程](http://blog.csdn.net/hacode/article/details/18982917)
