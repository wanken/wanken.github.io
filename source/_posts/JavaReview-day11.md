---
title: JavaReview-day11
date: 2018-01-19 12:01:06
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---

## 线程

### 进程和线程的区别

- 进程:
  是一个正在执行中的程序。
	每一个进程执行都有一个执行顺序。该顺序是一个执行路径，或者叫一个控制元。

- 线程：就是进程中的一个独立的控制单元。
		线程在控制着进程的执行。
### 特点
一个进程中至少有一个线程。


### 举例:
- Java VM  启动的时候会有一个进程java.exe.
  该进程中至少一有个线程负责java程序的执行。而且这个线程运行的代码存在于main方法中。该线程称之为主线程。

- 扩展：其实更细节说明jvm，jvm启动不止一个线程，还有负责垃圾回收机制的线程。


### 问题
1. 如何在自定义的代码中，自定义一个线程呢？

通过对api的查找，java已经提供了对线程这类事物的描述。就Thread类。

创建线程的第一种方式：继承Thread类。
- 步骤：
  1. 定义类继承Thread。
  2. 复写Thread类中的run方法。
  目的: 将自定义代码存储在run方法。让线程运行。

3. 调用线程的start方法，
	该方法两个作用：启动线程，调用run方法。

### 结论
发现运行结果每一次都不同。
因为多个线程都获取 **cpu的执行权**。cpu执行到谁，谁就运行。
明确一点，在某一个时刻，只能有一个程序在运行。(多核除外)
cpu在做着快速的切换，以达到看上去是同时运行的效果。
我们可以形象把多线程的运行行为在互相抢夺cpu的执行权。

- 这就是多线程的一个特性：随机性。谁抢到谁执行，至于执行多长，cpu说的算。

### 为什么要覆盖run方法呢？
Thread类用于描述线程。

该类就定义了一个功能，用于存储线程要运行的代码。该存储功能就是run方法。

也就是说Thread类中的run方法，用于存储线程要运行的代码。

```java
class Demo extends Thread
{
	public void run()
	{
		for(int x=0; x<60; x++)
			System.out.println("demo run----"+x);
	}
}

class ThreadDemo
{
	public static void main(String[] args)
	{
		//for(int x=0; x<4000; x++)
		//System.out.println("Hello World!");

		Demo d = new Demo();//创建好一个线程。
		//d.start();//开启线程并执行该线程的run方法。
		d.run();//仅仅是对象调用方法。而线程创建了，并没有运行。


		for(int x=0; x<60; x++)
			System.out.println("Hello World!--"+x);

	}
}
```


### 练习

```java
/*
练习：
创建两个线程，和主线程交替运行。

原来线程都有自己默认的名称。
Thread-编号 该编号从0开始。

static Thread currentThread():获取当前线程对象。
getName(): 获取线程名称。

设置线程名称：setName或者构造函数。
*/

class Test extends Thread
{
	//private String name;
	Test(String name)
	{
		//this.name = name;
		super(name);
	}
	public void run()
	{
		for(int x=0; x<60; x++)
		{
			System.out.println((Thread.currentThread()==this)+"..."+this.getName()+" run..."+x);
		}
	}

}


class ThreadTest
{
	public static void main(String[] args)
	{
		Test t1 = new Test("one---");
		Test t2 = new Test("two+++");
		t1.start();
		t2.start();
//		t1.run();
//		t2.run();

		for(int x=0; x<60; x++)
		{
			System.out.println("main....."+x);
		}
	}
}
```

### 线程的状态图
![](/images/post_images/javaReview_day11_img_01)

```java
/*
需求：
银行有一个金库。
有两个储户分别存300元，每次存100，存3次。

目的：该程序是否有安全问题，如果有，如何解决？


如何找问题：
1，明确哪些代码是多线程运行代码。
2，明确共享数据。
3，明确多线程运行代码中哪些语句是操作共享数据的。



*/


class Bank
{
	private int sum;
	//Object obj = new Object();
	public synchronized void add(int n)
	{
		//synchronized(obj)
		//{
			sum = sum + n;
			try{Thread.sleep(10);}catch(Exception e){}
			System.out.println("sum="+sum);
		//}
	}
}

class Cus implements Runnable
{
	private Bank b = new Bank();
	public void run()
	{		
		for(int x=0; x<3; x++)
		{
			b.add(100);
		}
	}
}


class  BankDemo
{
	public static void main(String[] args)
	{
		Cus c = new Cus();
		Thread t1 = new Thread(c);
		Thread t2 = new Thread(c);
		t1.start();
		t2.start();
	}
}
```


### 如果同步函数被静态修饰后, 使用的锁是什么呢？

通过验证，发现不在是this。因为静态方法中也不可以定义this。

静态进内存是，内存中没有本类对象，但是一定有该类对应的字节码文件对象。
类名.class  该对象的类型是Class


静态的同步方法，使用的锁是该方法所在类的字节码文件对象。 类名.class


```java

class Ticket implements Runnable
{
	private static  int tick = 100;
	//Object obj = new Object();
	boolean flag = true;
	public  void run()
	{
		if(flag)
		{
			while(true)
			{
				synchronized(Ticket.class)
				{
					if(tick>0)
					{
						try{Thread.sleep(10);}catch(Exception e){}
						System.out.println(Thread.currentThread().getName()+"....code : "+ tick--);
					}
				}
			}
		}
		else
			while(true)
				show();
	}
	public static synchronized void show()
	{
		if(tick>0)
		{
			try{Thread.sleep(10);}catch(Exception e){}
			System.out.println(Thread.currentThread().getName()+"....show.... : "+ tick--);
		}
	}
}


class  StaticMethodDemo
{
	public static void main(String[] args)
	{

		Ticket t = new Ticket();

		Thread t1 = new Thread(t);
		Thread t2 = new Thread(t);
		t1.start();
		try{Thread.sleep(10);}catch(Exception e){}
		t.flag = false;
		t2.start();


	}
}
```

### 买票小程序

需求：简单的卖票程序。
多个窗口同时买票。

```java
class Ticket implements Runnable//extends Thread
{
	private  int tick = 100;
	public void run()
	{
		while(true)
		{
			if(tick>0)
			{
				System.out.println(Thread.currentThread().getName()+"....sale : "+ tick--);
			}
		}
	}
}


class  TicketDemo
{
	public static void main(String[] args)
	{

		Ticket t = new Ticket();

		Thread t1 = new Thread(t);//创建了一个线程；
		Thread t2 = new Thread(t);//创建了一个线程；
		Thread t3 = new Thread(t);//创建了一个线程；
		Thread t4 = new Thread(t);//创建了一个线程；
		t1.start();
		t2.start();
		t3.start();
		t4.start();


		/*
		Ticket t1 = new Ticket();
		//Ticket t2 = new Ticket();
		//Ticket t3 = new Ticket();
		//Ticket t4 = new Ticket();

		t1.start();
		t1.start();
		t1.start();
		t1.start();
		*/

	}
}
```

### 创建线程的第二种方式：实现Runable接口

步骤：
1. 定义类实现Runnable接口
2. 覆盖Runnable接口中的run方法。
	将线程要运行的代码存放在该run方法中。

3. 通过Thread类建立线程对象。
4. 将Runnable接口的子类对象作为实际参数传递给Thread类的构造函数。
	为什么要将Runnable接口的子类对象传递给Thread的构造函数。
	因为，自定义的run方法所属的对象是Runnable接口的子类对象。
	所以要让线程去执行指定对象的run方法。就必须明确该run方法所属对象。


5. 调用Thread类的start方法开启线程并调用Runnable接口子类的run方法。



#### 实现方式和继承方式有什么区别呢？

- 实现方式好处：避免了单继承的局限性。
  在定义线程时，建意使用实现方式。

- 两种方式区别：
继承Thread:线程代码存放Thread子类run方法中。
实现Runnable，线程代码存在接口的子类的run方法。


## 线程同步(线程安全)
### 问题: 同步函数用的是哪一个锁呢？
函数需要被对象调用。那么函数都有一个所属对象引用。就是this。
所以同步函数使用的锁是this。

通过该程序进行验证。

使用两个线程来买票。
一个线程在同步代码块中。
一个线程在同步函数中。
都在执行买票动作。

```java
class Ticket implements Runnable
{
	private  int tick = 100;
	Object obj = new Object();
	boolean flag = true;
	public  void run()
	{
		if(flag)
		{
			while(true)
			{
				synchronized(this)
				{
					if(tick>0)
					{
						try{Thread.sleep(10);}catch(Exception e){}
						System.out.println(Thread.currentThread().getName()+"....code : "+ tick--);
					}
				}
			}
		}
		else
			while(true)
				show();
	}
	public synchronized void show()//this
	{
		if(tick>0)
		{
			try{Thread.sleep(10);}catch(Exception e){}
			System.out.println(Thread.currentThread().getName()+"....show.... : "+ tick--);
		}
	}
}


class  ThisLockDemo
{
	public static void main(String[] args)
	{

		Ticket t = new Ticket();

		Thread t1 = new Thread(t);
		Thread t2 = new Thread(t);
		t1.start();
		try{Thread.sleep(10);}catch(Exception e){}
		t.flag = false;
		t2.start();
//		Thread t3 = new Thread(t);
//		Thread t4 = new Thread(t);
//		t3.start();
//		t4.start();


	}
}

```

### 线程安全在单例设计模式中的应用

- 饿汉式
```java
class Single
{
	private static final Single s = new Single();
	private Single(){}
	public static Single getInstance()
	{
		return s;
	}
}
```

- 懒汉式

```java


class Single
{
	private static Single s = null;
	private Single(){}


	public static  Single getInstance()
	{
		if(s==null)
		{
			synchronized(Single.class)
			{
				if(s==null)
					//--->A;
					s = new Single();
			}
		}
		return s;
	}
}

class SingleDemo
{
	public static void main(String[] args)
	{
		System.out.println("Hello World!");
	}
}
```


### 死锁

死锁。
同步中嵌套同步。

```java
class Ticket implements Runnable
{
	private  int tick = 1000;
	Object obj = new Object();
	boolean flag = true;
	public  void run()
	{
		if(flag)
		{
			while(true)
			{
				synchronized(obj)
				{
					show();
				}
			}
		}
		else
			while(true)
				show();
	}
	public synchronized void show()//this
	{
		synchronized(obj)
		{
			if(tick>0)
			{
				try{Thread.sleep(10);}catch(Exception e){}
				System.out.println(Thread.currentThread().getName()+"....code : "+ tick--);
			}
		}
	}
}


class  DeadLockDemo
{
	public static void main(String[] args)
	{

		Ticket t = new Ticket();
		Thread t1 = new Thread(t);
		Thread t2 = new Thread(t);
		t1.start();
		try{Thread.sleep(10);}catch(Exception e){}
		t.flag = false;
		t2.start();
	}
}
```

#### 死锁练习
```java

class Test implements Runnable
{
	private boolean flag;
	Test(boolean flag)
	{
		this.flag = flag;
	}

	public void run()
	{
		if(flag)
		{
			while(true)
			{
				synchronized(MyLock.locka)
				{
					System.out.println(Thread.currentThread().getName()+"...if locka ");
					synchronized(MyLock.lockb)
					{
						System.out.println(Thread.currentThread().getName()+"..if lockb");					
					}
				}
			}
		}
		else
		{
			while(true)
			{
				synchronized(MyLock.lockb)
				{
					System.out.println(Thread.currentThread().getName()+"..else lockb");
					synchronized(MyLock.locka)
					{
						System.out.println(Thread.currentThread().getName()+".....else locka");
					}
				}
			}
		}
	}
}

class MyLock
{
	static Object locka = new Object();
	static Object lockb = new Object();
}

class  DeadLockTest
{
	public static void main(String[] args)
	{
		Thread t1 = new Thread(new Test(true));
		Thread t2 = new Thread(new Test(false));
		t1.start();
		t2.start();
	}
}
```

## 总结

- 进程：正在执行的程序。

- 线程：是进程中用于控制程序执行的控制单元(执行路径，执行情景)
进程中至少有一个线程。

- 对于JVM，启动时，只好有两个线程：jvm的主线程。jvm的垃圾回收线程。

**如何在程序中自定义线程呢？**

Java给我们提供了对象线程这类事物的描述。该类是Thread

该类中定义了，
创建线程对象的方法(构造函数).
提供了要被线程执行的代码存储的位置(run())

还定义了开启线程运行的方法(start()).
同时还有一些其他的方法用于操作线程：
	static Thread currentThead():
	String getName():
	static void sleep(time)throws InterruptedException:


要运行的代码都是后期定义的。
所以创建线程的第一种方式是：继承Thread类。原因：要覆盖run方法，定义线程要运行的代码。

步骤：
1. 继承Thread类。
2. 覆盖run方法。将线程要运行的代码定义其中。
3. 建Thread类的子类对象，其实就是在创建线程，调用start方法。



如果自定义的类中有多线程要运行的代码。但是该类有自己的父类。
那么就不可以在继承Thread。怎么办呢？

Java给我们提供了一个规则。Runnable接口。
如果自定义类不继承Thread，也可以实现Runnable接口。并将多线程要运行的代码存放在Runnable的run方法中。
这样多线程也可以帮助该类运行。
这样的操作有一个好处：避免了单继承的局限性。

创建线程的第二种方式：实现Runnable接口。

步骤：
1. 定义了实现Runnable接口。
2. 覆盖接口的run方法。将多线程要运行的代码存入其中。
3. 创建Thread类的对象(创建线程),并将Runnable接口的子类对象作为参数传递给Thread的构造函数。
	为什么要传递？因为线程要运行的代码都在Runnable子类的run方法中存储。所以要将该run方法所属的对象
	传递给Thread。让Thread线程去使用该对象调用其run方法。
4. 调用Thread对象的start方法。开启线程。

动手写代码。


两种方式的特点：
实现方式，因为避免了单继承的局限性，所以创建线程建议使用第二种方式。


### 第一重点：创建线程的两种方式#



作为了解：
线程的状态。
1. 被创建。
2. 运行。
3. 冻结。
4. 消亡。

其实还有一种特殊的状态：临时状态。

该临时状态的特点：
具备了执行资格，但不具备执行权。

**冻结状态的特点**：
- 放弃了执行资格。
多线程具备随机性。因为是由cpu不断的快速切换造成的。
就有可能会产生多线程的安全问题;

#### 问题的产生的原因：
几个关键点：
1. 多线程代码中有操作共享数据。
2. 多条语句操作该共享数据。

当具备两个关键点时，
有一个线程对多条操作共享数据的代码执行的一部分。还没有执行完，另一个线程开始参与执行。就会发生数据错误。

#### 解决方法：
当一个线程在执行多条操作共享数据代码时，其他线程即使获取了执行权，也不可以参与操作。


Java就对这种解决方式提供了专业的代码。
### 同步
同步的原理：就是将部分操作功能数据的代码进行加锁。

示例：火车上的卫生间。

同步的表现形式：
1. 同步代码块。
2. 同步函数。
两者有什么不同：
同步代码块使用的锁是任意对象。
同步函数使用的锁是this。


注意：对于static的同步函数，使用的锁不是this。是 类名.class 是该类的字节码文件对象。
	涉及到了单例设计模式的懒汉式。


#### 同步的好处：解决了线程的安全问题。

- 弊端：
	较为消耗资源。
	同步嵌套后，容易死锁。

**要记住**：同步使用的前提：
	1. 必须是两个或者两个以上的线程。
	2. 必须是多个线程使用同一个锁。
	这是才可以称为这些线程被同步了。

**死锁代码一定会写。但开发时一定注意避免。**




### 第二重点：同步的所有特性

```java

class Thread
{
	private Runnable target;

	Thread()
	{
	}
	Thread(Runnable target)
	{
		this.target = target;
	}

	public void run()
	{
		if(target!=null)
			target.run();
	}
}

class Test implements Runnable
{
	public void run()
	{}
}


main()
{
	Test q = new Test();
	Thread t = new Thread(q);
}


class Demo extends Thread
{
	public void run()
	{
	}
}
class  
{
	public static void main(String[] args)
	{
		System.out.println("Hello World!");
	}
}
```
