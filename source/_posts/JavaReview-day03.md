---
title: JavaReview-day03
date: 2017-11-28T15:04:34.000Z
type: JavaReview
categories:
  - JavaReview
tags:
  - Java
---

> Java

## 运算符

### 位运算符:

1."<<": 左位移 2.">>": 右位移: 左右为数值的二进制进行左右移动, 其结果等于原值 或 / 2的所以为数的次幂 即 3 << 3 = 3_ 2的三次幂 = 3 * 8 = 24; 3."<<<":无符号左移 4.">>>":无符号右移

异或(^)可以用于加密 '&', '|', '^'的运算

使两个变量互换值 m = 3; n = 8; n = n ^ m; m = n ^ m; n = n ^ m;即可完成值互换而不引用第三方变量完成两个变量的值互换

三元运算符 三元运算符会改变所运算元素的数据类型

### 语句

if...else:

三元运算符 对比 if...else 的优缺点 缺点: 三元运算符必须有结果 优点: 三元运算符比 if...else 简单, 可以简化 if...else

二. switch 语句:

1) switch可以中可以接收 byte, short, int char 类型的数据;

2) jdk1.5 加入对枚举类型的支持, jdk1.7 加入了对 String类型的支持;

3) switch 的各个 case 之间和 default 没有顺序,先执行第一个 case, 没有匹配的 case 执行default;


#### 结束 switch 语句的两种情况: (1).遇到 break; (2). 执行到 switch 语句结束;

#### 如果匹配的 case  没有对应的 break, 那么程序会继续向下执行, 运行可以执行的语句,
  直到遇到 break 或程序结束;

4) if ... else 和 switch 语句的对比:

#### switch 性能比 if...else 更高(if ... else 只能顺序执行)

#### 对区间判断可以或对结果为 boolean 类型的判断使用 if, if 的使用范围更广

##  while 语句

### do..while 和 while 的区别


#### do...while 先执行循环体, 再判断条件(循环体至少执行一次);
#### while 先判断再执行


## for语句

格式: for(初始化表达式; 循环条件表达式; 循环后表达式){ 执行语句; }


for 循环中的表达式只要为合法的表达式即可运行(循环表达式要有真或假的计算结果);


### for 循环中的变量初始化语句只执行一次

### for 循环中的语句不只是一句,多条语句可用 "," 隔开,如下:

```
  for(int x = 0, y = 0, z = 0; x < 4; x ++, y ++,z ++){
    System.out.println(x+y+z);
  }
```

### for 和 while 的无限循环的表达形式

```
 for:
  for(;;){
    System.out.println("for无限循环");
  }
```
### 如果 for 循环的条件不声明, 默认为 true;

### while
```
while(true){
  System.out.println(" while 无限循环");
}
```

## break 和 continue 1) break 可以跳出指定循环, 只需要将循环命名即可,具体实现如下


```
    public void testBreak() {
      w:
      for (int x = 1; x < 4; x++) {
          System.out.println("out\t");
          q:
          for (int m = 0; m < 3; m++){
              if (m == 2){
                  break w;
              }
              System.out.print("in\t");
          }
      }
      }
```

  输出结果为: out    in    in

  若将 break 后的 w 删掉,结果为: out    in    in    out    in    in    out    in    in


  2). continue
    作用:结束本次循环,继续下一次循环
    # 如下代码可以打印 0~10 以内的 2 的倍数:
```
        public void testContinue(){
            for (int i = 0; i < 11; i ++){
                if (i%2 == 1){
                    continue;
                }
            System.out.println(i);
            }
        }
```

### 1)  continue可以继续指定循环, 只需要将循环命名即可,具体实现如下
```
        public void testContinue() {
          w:
          for (int i = 0; i < 3; i++) {
            q:
            for (int k = 0; k < 4; k++) {
              System.out.println("i = " + i);
              continue w;
              }
          }
        }
```

输出结果为:
    ```
               i = 0
               i = 1
               i = 2
    ```
### break 和 continue语句单独存在时, 下面不可以有任何语句, 因为执行不到(编译报错);

### break 必须在 switch 或 loop(循环)语句内, continue必须在 loop 语句内

### 输出等腰三角形
```
public void testTriangle() {
for (int x = 1; x <= 5; x++) {
    for (int y = x; y < 5; y++) {
      System.out.print(" ");
    }
    for (int z = 0; z < x; z ++ ){
      System.out.print("* ");
      }
      System.out.println();
  }

}

```

  结果如下:

```
      *
     * *
    * * *
   * * * *
  * * * * *
```
## 重载 方法名一致, 但参数列表不同的函数为重载; 名称相同, 参数列表相同, 但返回值类型不同的两个函数不是重载函数, 不能同时存在于一个类中;
