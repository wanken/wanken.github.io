---
title: JavaReview-day10
date: 2018-01-17 11:54:27
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---


## 异常的格式

1. 第一种:
```java
try{

}catch(Exception e){

}

```

2. 第二种:
```java
try{

}catch(Exception e){

}
```
3. 第三种:
```java
try{

}finally{

}
```
- 第三种格式的特点及作用

```java
class ExceptionDemo{
  public void function(){
    throw new Exception();  
  }
}
```
以上代码会编译失败
但添加`finally`语句后即可编译成功, 如下:

```java
class ExceptionDemo{
  public void function(){
    try{
    throw new Exception();  
  }finally{

  }
  }
}
```
### 异常在子父类覆盖中的体现

1. 子类在覆盖父类时,如果父类的方法抛出异常, 那么子类的覆盖方法只能抛出父类的异常, 或该异常的子类;
2. 如果父类方法抛出多个异常, 那么子类方法在覆盖该方法时, 只能抛出父类异常的子集;
3. 如果父类或接口的方法中没有抛出异常, 那么子类在覆盖该方法时, 也不能抛出异常, 如果子类方法发生类异常, 就必须进行`try`处理, 绝对不能抛出;
```java
interface  Inter
{
	void function();
}

class D implements Inter
{
	public void function()//throws Exception
  {

  }
}

class A extends Exception{

}

class B extends A{

}
class C extends Exception{

}


// Exception
// 	|--A
// 		|--B
// 	|--C


class Fu
{
	void show()throws A{

  }
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

class ExceptionDemo
{
	public static void main(String[] args)
	{
		Test t = new Test();
		t.show(new Zi());
	}
}

```

## 总结


异常：
是什么？是对问题的描述。将问题进行对象的封装。
------------
异常体系：
	Throwable
		|--Error
		|--Exception
			|--RuntimeException

异常体系的特点：异常体系中的所有类以及建立的对象都具备可抛性。
				也就是说可以被throw和throws关键字所操作。
				只有异常体系具备这个特点。


--------------
throw和throws的用法：

throw定义在函数内，用于抛出异常对象。
throws定义在函数上，用于抛出异常类，可以抛出多个用逗号隔开。


当函数内容有throw抛出异常对象，并未进行try处理。必须要在函数上声明，都在编译失败。
注意，RuntimeException除外。也就说，函数内如果抛出的RuntimeExcpetion异常，函数上可以不用声明。
--------------


如果函数声明了异常，调用者需要进行处理。处理方法可以throws可以try。

异常有两种：
	编译时被检测异常
		该异常在编译时，如果没有处理(没有抛也没有try)，编译失败。
		该异常被标识，代表这可以被处理。
	运行时异常(编译时不检测)
		在编译时，不需要处理，编译器不检查。
		该异常的发生，建议不处理，让程序停止。需要对代码进行修正。



--------------
异常处理语句：
try
{
	需要被检测的代码；
}
catch ()
{
	处理异常的代码；
}
finally
{
	一定会执行的代码；
}

有三个结合格式：
1. 第一种
```java
try
	{

	}
	catch ()
	{
	}
```
2. 第二种
```java
try
	{

	}
	finally
	{

	}
```

3. 第三种
```java
try
	{

	}
	catch ()
	{
	}
	finally
	{

	}
```



## 注意:
1. finally中定义的通常是 关闭资源代码。因为资源必须释放。
2. finally只有一种情况不会执行。当执行到System.exit(0);fianlly不会执行。

--------------

### 自定义异常：
	定义类继承Exception或者RuntimeException
	1. 为了让该自定义类具备可抛性。
	2. 让该类具备操作异常的共性方法。

	当要定义自定义异常的信息时，可以使用父类已经定义好的功能。
	异常异常信息传递给父类的构造函数。
```java
	class MyException extends Exception
	{
		MyException(String message)
		{
			super(message);
		}
	}
```

## 自定义异常:
  按照java的面向对象思想，将程序中出现的特有问题进行封装。
--------------


## 异常的好处：
	1. 将问题进行封装。
	2. 将正常流程代码和问题处理代码相分离，方便于阅读。


## 异常的处理原则：
	1. 处理方式有两种：try 或者 throws。
	2. 调用到抛出异常的功能时，抛出几个，就处理几个。
		一个try对应多个catch。
	3. 多个catch，父类的catch放到最下面。
	4. catch内，需要定义针对性的处理方式。不要简单的定义printStackTrace，输出语句。
		也不要不写。
		当捕获到的异常，本功能处理不了时，可以继续在catch中抛出。
```java
  try
  {
  	throw new AException();
  }
  catch (AException e)
  {
  	throw e;
  }
```
如果该异常处理不了，但并不属于该功能出现的异常。
可以将异常转换后，在抛出和该功能相关的异常。

或者异常可以处理，当需要将异常产生的和本功能相关的问题提供出去，
当调用者知道。并处理。也可以将捕获异常处理后，转换新的异常。
```java
try
{
	throw new AException();
}
catch (AException e)
{
	// 对AException处理。
	throw new BException();
}
```
		比如，汇款的例子。


异常的注意事项：
	在子父类覆盖时：
	1，子类抛出的异常必须是父类的异常的子类或者子集。
	2，如果父类或者接口没有异常抛出时，子类覆盖出现异常，只能try不能抛。



参阅
ExceptionTest.java 老师用电脑上课
ExceptionTest1.java 图形面积。
```java
class  
{
	public static void main(String[] args)
	{
		int x = 0;
		try
		{
			x = 4;
		}
		catch ()
		{
		}
		finally
		{
			System.out.println("x="+x);
		}

	}
}
```
