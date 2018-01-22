---
title: JavaReview-day09
date: 2018-01-08T21:43:07.000Z
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---

# 内部类

内部类简介:
内部类是指在一个外部类的内部再定义一个类。类名不需要和文件夹相同。
*内部类可以是静态static的，也可用public，default，protected和private修饰。（而外部顶级类即类名和文件名相同的只能使用public和default）。*

**注意**：内部类是一个编译时的概念，一旦编译成功，就会成为完全不同的两类。对于一个名为outer的外部类和其内部定义的名为inner的内部类。编译完成后出现outer.class和outer$inner.class两类。所以内部类的成员变量/方法名可以和外部类的相同。

``` java
public class Outer {
    static int mun = 6;

    class Inner//内部类。
    {
        void show() {
            System.out.println("show run..." + mun);
        }
        //static void function()//如果内部类中定义了静态成员，该内部类也必须是静态的。
        //{
        //    System.out.println("function run ...."+num);
        //}
    }

    public void method() {
        Inner in = new Inner();
        in.show();
    }
}


class InnerClassDemo {
    public static void main(String[] args) {
    //Outer out = new Outer();
    //out.method();
    //直接访问外部类中的内部类中的成员。
    //Outer.Inner in = new Outer().new Inner();
    //in.show();

    //如果内部类是静态的。 相当于一个外部类
    //Outer.Inner in = new Outer.Inner();
    //in.show();

    //如果内部类是静态的，成员是静态的。
    //Outer.Inner.function();
    }
}
```

## 内部类的访问规则

1. 内部类可以直接访问外部类中的成员, 包括私有, 这是因为内部类中持有一个外部类的引用, 格式 `外部类名.this`
2. 外部类要访问内部类, 必须建立内部类的对象

## 访问格式:

1. 当内部类定义在外部类的成员位置上, 而且非私有, 可以在 **外部其他类** 中, 可以直接建立内部类对象

  - 格式: `外部类名.内部类名 变量名 = 外部类对象.内部类对象;`
  - 代码: `Outer.Inner inner = new Outer(). new Inner();`
  2.
  ``` java
  public class day09 {

    public static void main(String[] args) {
      Outer.Inner inner = new Outer(). new Inner();
      inner.function();
     }
    }

class Outer{
  public int x = 3; class Inner{
    int x = 4;
    void function(){
      int x = 6;
      System.out.println("X value:" + x);
      System.out.println("X value:" + this.x);
      System.out.println("X value:" + Outer.this.x);
    }
  }

}

```

输出结果为:
`
6
3
4
`

## 局部中的内部类

内部类定义在局部时:
- 不可以被成员修饰符修饰;
- 可以直接访问外部类中的成员, 因为还持有外部类中的引用
  但是不可以访问它所在的局部中的变量. 只能访问被 `final` 修饰的局部变量;

``` java
public class Outer {
  int x = 3;
  void method(){
    final int y = 4;
    class Inner{
      void function(){
        System.out.println(y);
      }
      new Inner.function();
    }
  }

class InnerClassDemo3{
    public static void main(String[] args) {
      Outer out = new Outer().method();
      out.method(7);
      out.method(8);
    }
}

}
```

## 匿名内部类

1. 匿名内部类就是内部类的简写格式
2. 定义匿名内部类的前提:
  - 内部类必须是继承一个类或实现接口
3. 匿名内部类的格式: new 父类对象或接口(){定义子类的内容}
4. 其实匿名内部类就是一个匿名子类对象. 而且这个对象有点胖. 可以理解为带内容的对象;

``` java

abstract class AbsDemo{
  abstract void show();
}

class Outer{
  int x = 3;
  AbsDemo d = new AbsDemo(){
    void show(){
      System.out.println("x==" + x);
    }
    void abc(){
      System.out.println("haha");
    }
  };
}
d.show();
//d.abc();//编译失败 因为只能使用父类的引用,无法调用

```

## 异常
1. 异常:就是程序在运行时出现不正常情况.
异常的由来: 问题也是现实生活中一个具体的事物, 也可以通过java的类的形式进行描述. 并封装成对象.
2. 对于问题的划分为两种:
 一种是严重的问题, 一种非严重的问题;

- 对于严重的, java 通过`Error`类进行描述:
    对于`Error`一般不编写针对性的代码对其进行处理;
- 对于非严重的, java 通过`Exception`类进行描述.
  对于`Exception`可以使用针对性的处理方式进行处理;


异常：是在运行时期发生的不正常情况
在java中用类的形式对不正常情况进行了描述和封装对象。
描述不正常的情况的类，就称为异常类。
以前正常流程代码和问题处理代码相结合，
现在将正常流程代码和问题处理代码分离。提高阅读性.
其实异常就是java通过面向对象的思想将问题封装成了对象.
用异常类对其进行描述。
不同的问题用不同的类进行具体的描述。 比如角标越界。空指针等等。
问题很多，意味着描述的类也很多，
将其共性进行向上抽取，形成了异常体系。
最终问题（不正常情况）就分成了两大类。
Throwable:无论是error，还是异常，问题，问题发生就应该可以抛出，让调用者知道并处理。
	//该体系的特点就在于Throwable及其所有的子类都具有可抛性。
	可抛性到底指的是什么呢？怎么体现可抛性呢？
	其实是通过两个关键字来体现的。
	throws throw ,凡是可以被这两个关键字所操作的类和对象都具备可抛性.
	- 一般不可处理的。Error
			特点：是由jvm抛出的严重性的问题。
				 这种问题发生一般不针对性处理。直接修改程序
	- 可以处理的。Exception


  - 该体系的特点：
	 子类的后缀名都是用其父类名作为后缀，阅读性很想。

``` java
class ExceptionDemo
{
	public static void main(String[] args)
	{
		int[] arr = new int[1024*1024*800];//java.lang.OutOfMemoryError: Java heap space
//		arr = null;
//		System.out.println(arr[3]);
//
//
//		sleep(-5);
	}


	public static void sleep2(int time)
	{
		if(time<0)
		{
      //处理办法。
      //处理办法。
      //处理办法。
      //处理办法。
      //处理办法。
		}
		if(time>100000)
		{
    //处理办法。
    //处理办法。
    //处理办法。
    //处理办法。
    //处理办法。
    //处理办法。
		}
		System.out.println("我睡。。。"+time);

//		sleep(-5);
	}
	public static void sleep(int time)
	{
		if(time<0)
		{
//			抛出 new FuTime();//就代码着时间为负的情况，这个对象中会包含着问题的名称，信息，位置等信息。
		}
		if(time>100000)
		{
//			抛出 new BigTime();
		}
		System.out.println("我睡。。。"+time);
	}
}
/*
class FuTime
{
}
class BigTime
{
}
*/
```

### 运行时异常

对于角标是整数不存在，可以用角标越界表示，
对于负数为角标的情况，准备用负数角标异常来表示。

负数角标这种异常在java中并没有定义过。
那就按照java异常的创建思想，面向对象，将负数角标进行自定义描述。并封装成对象。

这种自定义的问题描述成为自定义异常。

注意：如果让一个类称为异常类，必须要继承异常体系，因为只有称为异常体系的子类才有资格具备可抛性。
才可以被两个关键字所操作，throws throw




### 异常的分类：
1. 编译时被检测异常:只要是Exception和其子类都是，除了特殊子类RuntimeException体系。
  这种问题一旦出现，希望在编译时就进行检测，让这种问题有对应的处理方式。
  这样的问题都可以针对性的处理。


2. 编译时不检测异常(运行时异常):就是Exception中的RuntimeException和其子类。
这种问题的发生，无法让功能继续，运算无法进行，更多是因为调用者的原因导致的而或者引发了内部状态的改变导致的。
那么这种问题一般不处理，直接编译通过，在运行时，让调用者调用时的程序强制停止,让调用者对代码进行修正。

所以自定义异常时，要么继承Exception。要么继承RuntimeException。

### throws 和 throw 的区别。

1. throws使用在函数上。
   throw使用在函数内。
2. throws抛出的是异常类，可以抛出多个，用逗号隔开。
   throw抛出的是异常对象。


   异常处理的捕捉形式：
   这是可以对异常进行针对性处理的方式。

   具体格式是：

``` java
   try
   {
   	//需要被检测异常的代码。
   }
   catch(异常类 变量)//该变量用于接收发生的异常对象
   {
   	//处理异常的代码。
   }
   finally
   {
   	//一定会被执行的代码。
     }
```

### 异常处理的原则：
1. 函数内容如果抛出需要检测的异常，那么函数上必须要声明。
否则必须在函数内用trycatch捕捉，否则编译失败。

2. 如果调用到了声明异常的函数，要么trycatch要么throws，否则编译失败。

3. 什么时候catch，什么时候throws 呢？
功能内容可以解决，用catch。
解决不了，用throws告诉调用者，由调用者解决 。

4. 一个功能如果抛出了多个异常，那么调用时，必须有对应多个catch进行针对性的处理。
内部又几个需要检测的异常，就抛几个异常，抛出几个，就catch几个。


### 异常的注意事项

1. 子类在覆盖父类方法时，父类的方法如果抛出了异常，
那么子类的方法只能抛出父类的异常或者该异常的子类。

2. 如果父类抛出多个异常，那么子类只能抛出父类异常的子集。
简单说：子类覆盖父类只能抛出父类的异常或者子类或者子集。

注意：如果父类的方法没有抛出异常，那么子类覆盖时绝对不能抛，就只能try .

``` java
interface  Inter
{
	void function();
}

class D implements Inter
{
	public void function()//throws Exception
	{}
}

class A extends Exception
{
}

class B extends A
{
}
class C extends Exception
{
}


class Fu
{
	void show()throws A
	{}
}


class Test
{
	void method(Fu f)//Fu f  = new Zi();
	{
		try
		{
			f.show();

		}
		catch (A  a)
		{
		}
	}
}


class Zi extends Fu
{
	void show()throws C
	{

	}
}
```
