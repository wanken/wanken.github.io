---
title: 工具推荐-第一期-AutoHotKey
date: 2018-01-28 17:32:04
tags:
  - 工具推荐
  - 工作效率
categories:
  - 程序人生
type:
  - 程序人生
---
最近发现一款高(neng)大(zhuang)上(bi)的神器-------AutoHotKey, 可以自定义Windows的快捷键, 可以使你彻底脱离鼠标, 这酸爽, 谁用谁知道.

下载地址: [www.autohotkey.com](https://www.autohotkey.com/)
中文帮助文档下载: [帮助文档](https://waver.me/Resource/Files/AutoHotkey.chm)
最后附上ChinaUnix博主xiaogangzgg写的教程: [AutoHotkey的几个入门级应用](http://blog.chinaunix.net/uid-26811377-id-3166486.html)

## 入门教程

### 创建第一个AHK脚本
1. 在桌面或您选择的文件夹中右键点击空白处.
2. 在菜单中, 选择 新建-> 文本文档.
3. 输入文件名, 将`.txt`后缀修改成`.ahk`. 例如：Test.ahk。
    若没有后缀,请参见[win10文件后缀名怎么显示](https://jingyan.baidu.com/article/ff42efa920b7f3c19e220283.html)
4. 右键点击此文件并选择 Edit Script.
6. 在新的空行中，输入下列内容：#space::Run www.google.com。

在上面的语句行中, 首个字符 "#" 表示 Windows 键; 所以 #space 表示按住 Windows 键然后按下空格键来激活热键. 双冒号 :: 表示每次按下此热键时会执行其后续命令, 这里是转到 Google 网站. 要试用此脚本, 请继续下列操作:
1. 保存并关闭此文件.
2. 双击此文件来运行. 在任务栏通知区域会出现新的图标.
3. 按住 Windows 键并按下空格键. 在默认浏览器中会打开网页.
4. 要退出或编辑此脚本, 则在任务栏通知区域的绿色 "H" 图标上点击右键.

注意:
- 多个脚本可以同时运行, 其中的每个脚本在任务栏通知区域使用自己的图标.
- 每个脚本可以包含多个[热键]和[热字串].
- 要让您的脚本在启动计算机时自动运行, 请在开始菜单的启动文件夹中给您的脚本创建快捷方式.

<font color='red'>**[热键]和[热字串]对照表请参见文档**</font>

## 以下是本人常用的一些脚本(不定期更新)
### 1.调节音量
虽然Windows已经有默认的音量调节按钮, 但是总觉得不爽, 特别是光线比较暗的时候,几乎找不到好吗(没有背光键盘的平民程序员), 下面附上脚本
```
;调节音量
!Right::SoundSet, +1,, mute ;Alt + 右方向键 开关声音
!Up::                       ;Alt + 上方向键 增加音量 SoundSet +1 中的 `+1`代表每次按键的精度
SoundSet +1, MASTER
SoundSet, +1, WAVE
Return
!Down::                     ;Alt + 下方向键 降低音量
SoundSet -1, MASTER
SoundSet, -1,WAVE
Return
```
