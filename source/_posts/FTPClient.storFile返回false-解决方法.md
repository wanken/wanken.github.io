---
title: FTP storFile返回false 解决方法
date: 2017-12-04T19:59:29.000Z
tags:
  - Java
  - FTP
categories:
  - Exception
type:
  - Java
  - FTP
---

[本文参考地址](https://www.cnblogs.com/xiangpiaopiao2011/archive/2012/02/28/2371679.html#undefined)

## 错误描述

- 自己搭建的FTP服务器总是在执行FTPClient.storFile(); 方法时返回 false


## 解决方法

- 添加以下代码即可

  ```
    ftpClient.setControlEncoding("UTF-8");
  ```
