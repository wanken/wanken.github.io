---
title: GitHub Pages绑定域名
date: 2017-12-17 13:11:03
tags: Blog
type: Blog
---

本文主要讲述博客选购和绑定域名, 博客搭建部分不再赘述

## 购买域名
如果嫌麻烦可以在[Godaddy](https://www.godaddy.com/) 购买
也可以在国内阿里云或腾讯云等购买, 本文主要介绍在 Godaddy 购买并绑定教程

### 选购域名
  可以在[此页面](https://sg.godaddy.com/zh/domains/domain-name-search)搜索你喜欢的
域名是否被占用, 如果未被占用, 至于域名后缀选择, 可参考[知乎答案](https://www.zhihu.com/question/19610337) 推荐使用`.me`

### 域名解析
#### 更换域名服务器
  Godaddy 的默认 DNS 解析在国内不是很稳定, 推荐使用[DNSPot](https://www.dnspod.cn/)
解析域名, 在 DNSPot 注册账户后绑定在Godaddy注册的域名, 然后将图1中的红色区域设置到
Godaddy 的域名服务器
![图1](/images/post_images/20171217_DNSPot.jpg)
![图2](/images/post_images/20171217_GoDaddy_DNS.jpg)
注意: 在GoDaddy中配置的为"f1g1ns1.dnspod.net", 为没有"f1g1ns1.dnspod.net."要去掉最
后的 `.`

#### GitHub中的域名支持
  GitHub的服务器域名是个固定IP。所以，当我们需要将申请的域名给予一个自己的github.io的地
址的时候，我们可以在DNS服务器的配置中添加一条A记录，指向github的服务器地址。如图2第一条记录所示

现在github的服务器地址为：
  - 192.30.252.153
  - 192.30.252.154

## 添加CNAME文件
在你的博客仓库中下的 `/source` 目录中添加名为 `CNAME`的文件, 在文件中写入你在GoDaddy
注册的域名, 至此, 所有 GitHub Pages 的域名的工作就完成了, Enjoy you blog!
