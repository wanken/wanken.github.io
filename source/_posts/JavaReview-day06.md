---
title: JavaReview-day06
date: 2017-11-30T19:49:08.000Z
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---

# Java复习第6天

## static 关键字

### static 的特点:

1. 内存特点

  - 存储位置: data segment(数据区 [也叫 共享区/方法区]);
  - 可以通过 "类名.静态成员" 的方式调用;
  - 随着类的加载而加载, 随着类的消失而消失(说明它的生命周期最长);
  - 优先于对象存在(加载);
  - 被所有对象所共享
  - 只有数据被多个对象共享是才适合定义静态
  - 可以直接被类名调用

### 静态变量和非静态变量的举例

```java
    class Person{
         String name;//成员变量，实例变量
       static String country = "CN";//静态变量。类变量
       public  void show(){

         System.out.println(Person.country+":"+this.name);

        }
      }
```

- 静态变量又叫类变量或静态成员变量, 非静态变量也叫成员变量或实例变量

- 静态变量和非静态变量的访问权限的不同

  - static方法只能访问static的变量，没有权限访问非static变量。
  - static方法中声明的变量可以与非static变量并且是类的属性重名
  - 方法中声明的变量可以与非static变量并且是类的属性重名
  - 非static方法中可以方访问static变量。
  - static方法可以访问static属性

### 实例变量(静态变量)和类变量(非静态变量)的区别

1. 存放位置:

  - 类变量随着类的加载而存在于方法区中;
  - 实例变量随着对象的建立而存在于堆内存中;

2. 生命周期:

  - 类变量的生命周期最长,随着类的消失而消失;
  - 实例变量随着对象的消失而消失;

### 静态使用注意事项

- 静态方法只能访问静态变量成员, 非静态方法既可以访问静态成员也可以访问非静态成员;
- 静态方法中不可以定义 this, super 关键字, 因为静态成员优先于对象存在, 所以静态 方法中不可能存在this;
- 主函数(main) 也是静态的;

## main()函数

1. 主函数: 是一个特殊的函数; 作为程序的入口, 可以被 JVM 调用;
2. 主函数的定义:

  - public: 代表着该函数访问权限是最大的;
  - static: 代表主函数随着类的加载就已经存在了;
  - void: 主函数没有具体的返回值;
  - main: 不是关键字, 但是是一个特殊的单词, 可以被 JVM 识别;
  - (String[] args): 函数的参数,参数类型是一个字符串类型的数组;

3. 主函数的格式是固定的: JVM 可以识别的;

4. JVM 在调用主函数时, 传入的参数是 new String[0];

5. 可以在通过命令行运行时使用以下方式向 main 函数中传入参数:

  ```bash
  $java MainDemo hehe enen oo
  ```

  PS: 向 main 函数中传入 "hehe" "enen" "oo" 三个参数

```java
  class MainDemo
  {
      public static void main(String[] args) {
        String[] arr = {"hehe", "haha", "oo", "enen"}
        TestMain.main(arr);
      }
  }
  class TestMain{
    public static void main(String[] args) {
      for(int x=0; x<args.length; x++){
          System.out.println(args[x]);
      }
    }
  }
```

### 静态的使用条件

#### 可以分为两部分(因为静态修饰的内容有成员变量和函数):

1. 什么时候定义静态变量:

  - 当对象中出现共享的数据时, 该数据被静态所修饰;
  - 对象中的特有数据要定义成非静态, 存在于堆内存中;

2. 什么时候定义静态方法:

  - 当功能内部没有访问到非静态数据(对象特有数据)时, 那么该功能可以定义成静态的;

### JVM的编译特点

- JVM编译文件时会先查找当前类中对其他类的引用, 如果有其引用的 **class文件**,如果没有, 再查找与其同名的 **java文件**,如果有, 先编译其 java 文件, 然后在编译当前文件, 没有则报错;

### 类加载的特点

- 只有用到类中的内容是, 类才被加载

```java
class Demo{
  System.out.println("a");
}
class TestDemo{
  public static void main(String[] args) {
    Demo demo = null;
  }

}
```

以上代码执行后没有运行结果, 因为 `TestDemo` 中并没有实际用到 `Demo` 中的内容

## Java 帮助文档

### Java注释常用标签实例

- @see 引用其他类: @see标签允许你引用其他类的文档。javadoc会在其生成的HTML文件中，用@see标签链接到其他文档。
- @link package. class#member label 该标签与@see及其相似，只是它可以用于行内，并且是用"label"作为超链接文本而不用"See Also"
- @docRoot 该标签产生到文档根目录的相对路径，用于文档树页面的显示超链接
- @inheritDoc 该标签从当前这个类的最直接的基类中继承相关文档到当前的文档注释中
- @version 该标签格式如下： @version version-information 其中，"version-information"可以是任何你认为适合作为版本说明的重要信息，如果javadoc命令行使用了"-version"标记，那么久可以从生成的HTML文档中提取出版本信息
- @author 该标签的格式如下： @author author-information 其中，"author-information",望文生义你也知道，应该是你的名字，也可以包括电子邮件地址或者其他任何适宜的信息
- @since 该标签允许你指定程序代码最早使用的版本，你将会在HTML java文档中看到他被用来指定所用的JDK版本
- @param 该标签用于方法文档中，形式如下： @param parameter-name description 其中，parameter-name是方法的参数列表中标识符
- @throws 异常
- @deprecated 该标签用于指出一些旧特性已由改进的新特性所取代，建议用户不要使用这些旧特征。

### Java注释的使用顺序

1. @author (classes and interfaces only, required)
2. @version (classes and interfaces only, required. See footnote 1)
3. @param (methods and constructors only)
4. @return (methods only)
5. @exception (@throws is a synonym added in Javadoc 1.2)
6. @see
7. @since
8. @serial (or @serialField or @serialData)
9. @deprecated (see How and When To Deprecate APIs)

### 注意

- 一个类中默认会有一个空参数的构造函数, 这个默认构造函数的权限和所属类一致;
- 默认构造函数的权限是随着类的权限变化而变化的;

### 静态代码块

- 格式:

  ```java
  class{
    static{
        //静态代码块中的执行语句
    }
  }
  ```

- 特点: 随着类的加载而执行, **且只执行一次**;

- 作用: 用于给类初始化

### 应用: 类中各个代码块之间的执行顺序

```java

  class StaticCode{

    StaticCode(){
      System.out.print("b ");
    }

    static{
      System.out.print("a ");
    }

    {
      System.out.print("c ");
    }

    StaticCode(int x){
      System.out.print("d ");
    }
  }
class StaticCodeDemo{
  public static void main(String[] args) {
    new StaticCode(4);
  }
}
```

- 以上代码的输出结果是: `a c d`

  #### 原因:

  - 静态代码块的作用是给

    <font color="red">
      <strong>类</strong>
    </font>

    初始化的, 随着类的加载而执行, **且只执行一次**;
  - 构造代码块的作用是给

    <font color="red">
      <strong>对象(所有对象)</strong>
    </font>

    初始化的,对象一建立就运行, 而且优先于构造函数执行;
  - 构造函数的作用是给

    <font color="red">
      <strong>对应对象</strong>
    </font>

    初始化

参考链接: [Java中普通代码块，构造代码块，静态代码块区别及代码示例](https://www.cnblogs.com/sophine/p/3531282.html)

### 总结

1. 虚拟机在首次加载Java类时，会对静态初始化块、静态成员变量、静态方法进行一次初始化
2. 只有在调用new方法时才会创建类的实例
3. 类实例创建过程：按照父子继承关系进行初始化，首先执行父类的初始化块部分，然后是父类的构造方法；再执行本类继承的子类的初始化块，最后是子类的构造方法
4. 类实例销毁时候，首先销毁子类部分，再销毁父类部分

## 对象的初始化过程

```java
class class Person
{
    private int age;
    private String name = "Jack";
    private static String country = "CN";

    Person(String name, int age){
      this.name = name;
      this.age = age;
    }

    public void speak()
    {
        System.out.println("name=" + this.name + ", age="+age);
    }
}

class  PersonDemo
{
    public static void main(String[] args)
    {
        Person p = new Person("Tom", 20);
    }

}
```
以上代码中 `Person p = new Person("Tom", 20)`执行时 Java 所完成的工作:
1. 在栈内存中创建变量 'p';
2. 因为 "new" 用到了 <font color="red">"**Person.class**"</font>, 所以先找到<font color="red">"**Person.class**"</font>文件并加载到
   内存中
3. 执行该类中的 <font color="red">**static 代码块**</font>, 给 <font color="red">"**Person 类**"</font>进行初始化
4. 在堆内存中开辟空间, 并分配内存地址
5. 在内存中建立对象的特有属性, 并进行默认初始化
6. 对属性进行显示初始化
7. 对对象进行构造代码块初始化
8. 对对象进行对应的构造函数初始化
9. 将内存地址赋给栈内存中的 'p' 变量

### 对象调用成员过程



### 单例设计模式

#### 例子

下面是一个简单的单例设计模式的例子
```java

  class Single{

    private Single(){}
    private static Single s = new Single();
    private static Single getInstance(){
      return s;
    }
  }

  class SingleDemo{
    public static void main(String[] args) {
      Single s = Single.getInstance();
    }
  }
```
#### 饿汉式

```java

  class Single{
    private Single(){}
    private static Single single = new Single();
    public static Single getInstance(){
      return single;
    }
  }

```

### 懒汉式

```java

  class Single{
    private Single(){}
    private static Single single = null;
    public static Single getInstance(){
      if (single == null) {
        //如果在此卡住, 则会出现多个对象
        single = new Single();
      }
      return single;
    }

  }

```

##### 懒汉式和饿汉式的区别

- 饿汉式不管调不调用, 都会先加载对象, 而懒汉式则会在需要时才会进行加载对象

##### 懒汉式最终解决方案
```java
  class Single{
    private Single(){}
    private static Single single = null;
    public static Single getInstance(){
      if (single == null) {
        synchronized(Single.class){
          if (single == null) {
            single = new Single();
          }
        }

      }
      return single;
    }

  }
```

##### 注意!
- 懒汉式加载会有安全性问题: 如果同时被多个对象同时调用, 则会出现多个对象
- 开发用饿汉式
