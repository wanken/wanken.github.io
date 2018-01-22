---
title: JavaReview-day12-线程通信
date: 2018-01-20 15:20:31
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---


## 线程通信


<font color='red'>线程间通讯：
其实就是多个线程在操作同一个资源，
但是操作的动作不同。</font>

``` java
class ProducerConsumerDemo
{
	public static void main(String[] args)
	{
		Resource r = new Resource();

		Producer pro = new Producer(r);
		Consumer con = new Consumer(r);

		Thread t1 = new Thread(pro);
		Thread t2 = new Thread(pro);
		Thread t3 = new Thread(con);
		Thread t4 = new Thread(con);

		t1.start();
		t2.start();
		t3.start();
		t4.start();

	}
}
```
对于多个生产者和消费者。
为什么要定义while判断标记。
原因：让被唤醒的线程再一次判断标记。


为什么定义`notifyAll`，
因为需要唤醒对方线程。
因为只用notify，容易出现只唤醒本方线程的情况。导致程序中的所有线程都等待。



``` java
class Resource
{
	private String name;
	private int count = 1;
	private boolean flag = false;
			//  t1    t2
	public synchronized void set(String name)
	{
		while(flag)
			try{this.wait();}catch(Exception e){}//t1(放弃资格)  t2(获取资格)
		this.name = name+"--"+count++;

		System.out.println(Thread.currentThread().getName()+"...生产者.."+this.name);
		flag = true;
		this.notifyAll();
	}


	//  t3   t4  
	public synchronized void out()
	{
		while(!flag)
			try{wait();}catch(Exception e){}//t3(放弃资格) t4(放弃资格)
		System.out.println(Thread.currentThread().getName()+"...消费者........."+this.name);
		flag = false;
		this.notifyAll();
	}
}

class Producer implements Runnable
{
	private Resource res;

	Producer(Resource res)
	{
		this.res = res;
	}
	public void run()
	{
		while(true)
		{
			res.set("+商品+");
		}
	}
}

class Consumer implements Runnable
{
	private Resource res;

	Consumer(Resource res)
	{
		this.res = res;
	}
	public void run()
	{
		while(true)
		{
			res.out();
		}
	}
}
```

### 进程同步优化解决方案


JDK1.5 中提供了多线程升级解决方案。
将同步Synchronized替换成显式的Lock操作。
将Object中的wait，notify notifyAll，替换了Condition对象。
该对象可以Lock锁 进行获取。
该示例中，实现了本方只唤醒对方操作。

- Lock:替代了Synchronized
  	lock
  	unlock
  	newCondition()

- Condition：替代了Object wait notify notifyAll
  	await();
  	signal();
  	signalAll();

``` java
import java.util.concurrent.locks.*;

class ProducerConsumerDemo2
{
	public static void main(String[] args)
	{
		Resource r = new Resource();

		Producer pro = new Producer(r);
		Consumer con = new Consumer(r);

		Thread t1 = new Thread(pro);
		Thread t2 = new Thread(pro);
		Thread t3 = new Thread(con);
		Thread t4 = new Thread(con);

		t1.start();
		t2.start();
		t3.start();
		t4.start();

	}
}

class Resource
{
	private String name;
	private int count = 1;
	private boolean flag = false;
			//  t1    t2
	private Lock lock = new ReentrantLock();

	private Condition condition_pro = lock.newCondition();
	private Condition condition_con = lock.newCondition();



	public  void set(String name)throws InterruptedException
	{
		lock.lock();
		try
		{
			while(flag)
				condition_pro.await();//t1,t2
			this.name = name+"--"+count++;

			System.out.println(Thread.currentThread().getName()+"...生产者.."+this.name);
			flag = true;
			condition_con.signal();
		}
		finally
		{
			lock.unlock();//释放锁的动作一定要执行。
		}
	}


	//  t3   t4  
	public  void out()throws InterruptedException
	{
		lock.lock();
		try
		{
			while(!flag)
				condition_con.await();
			System.out.println(Thread.currentThread().getName()+"...消费者........."+this.name);
			flag = false;
			condition_pro.signal();
		}
		finally
		{
			lock.unlock();
		}

	}
}

class Producer implements Runnable
{
	private Resource res;

	Producer(Resource res)
	{
		this.res = res;
	}
	public void run()
	{
		while(true)
		{
			try
			{
				res.set("+商品+");
			}
			catch (InterruptedException e)
			{
			}

		}
	}
}

class Consumer implements Runnable
{
	private Resource res;

	Consumer(Resource res)
	{
		this.res = res;
	}
	public void run()
	{
		while(true)
		{
			try
			{
				res.out();
			}
			catch (InterruptedException e)
			{
			}
		}
	}
}
```

``` java
class Res
{
	private String name;
	private String sex;
	private boolean flag = false;

	public synchronized void set(String name,String sex)
	{
		if(flag)
			try{this.wait();}catch(Exception e){}
		this.name = name;

		this.sex = sex;
		flag = true;
		this.notify();
	}
	public synchronized void out()
	{
		if(!flag)
			try{this.wait();}catch(Exception e){}
		System.out.println(name+"........"+sex);
		flag = false;
		this.notify();
	}
}

class Input implements Runnable
{
	private Res r ;
	Input(Res r)
	{
		this.r = r;
	}
	public void run()
	{
		int x = 0;
		while(true)
		{
			if(x==0)				
				r.set("mike","man");				
			else
				r.set("丽丽","女女女女女");				
			x = (x+1)%2;
		}
	}
}

class Output implements Runnable
{
	private Res r ;

	Output(Res r)
	{
		this.r = r;
	}
	public void run()
	{
		while(true)
		{
			r.out();
		}
	}
}


class  InputOutputDemo2
{
	public static void main(String[] args)
	{
		Res r = new Res();

		new Thread(new Input(r)).start();
		new Thread(new Output(r)).start();
		/*
		Input in = new Input(r);
		Output out = new Output(r);

		Thread t1 = new Thread(in);
		Thread t2 = new Thread(out);

		t1.start();
		t2.start();
		*/
	}
}

```


**等待的线程存放在线程池中**
**最先唤醒的是最先被冻结的线程**


### 停止线程


**stop方法已经过时。**

如何停止线程？
只有一种，run方法结束。
开启多线程运行，运行代码通常是循环结构。
只要控制住循环，就可以让run方法结束，也就是线程结束。

特殊情况：
当线程处于了冻结状态。
就不会读取到标记。那么线程就不会结束。

当没有指定的方式让冻结的线程恢复到运行状态是，这时需要对冻结进行清除。
强制让线程恢复到运行状态中来。这样就可以操作标记让线程结束。

Thread类提供该方法 `interrupt()`;

``` java

class StopThread implements Runnable
{
	private boolean flag =true;
	public  void run()
	{
		while(flag)
		{

			System.out.println(Thread.currentThread().getName()+"....run");
		}
	}
	public void changeFlag()
	{
		flag = false;
	}
}




class  StopThreadDemo
{
	public static void main(String[] args)
	{
		StopThread st = new StopThread();

		Thread t1 = new Thread(st);
		Thread t2 = new Thread(st);


		t1.setDaemon(true);
		t2.setDaemon(true);
		t1.start();
		t2.start();

		int num = 0;

		while(true)
		{
			if(num++ == 60)
			{
				//st.changeFlag();
				//t1.interrupt();
				//t2.interrupt();
				break;
			}
			System.out.println(Thread.currentThread().getName()+"......."+num);
		}
		System.out.println("over");
	}
}
```


### 守护进程

join:
当A线程执行到了B线程的.join()方法时，A就会等待。等B线程都执行完，A才会执行。

join可以用来临时加入线程执行。


``` java

class Demo implements Runnable
{
	public void run()
	{
		for(int x=0; x<70; x++)
		{
			System.out.println(Thread.currentThread().toString()+"....."+x);
			Thread.yield();
		}
	}
}


class  JoinDemo
{
	public static void main(String[] args) throws Exception
	{
		Demo d = new Demo();
		Thread t1 = new Thread(d);
		Thread t2 = new Thread(d);
		t1.start();

		//t1.setPriority(Thread.MAX_PRIORITY);

		t2.start();

		//t1.join();

		for(int x=0; x<80; x++)
		{
			//System.out.println("main....."+x);
		}
		System.out.println("over");
	}
}
```

### 练习

``` java
class MyThread extends Thread{
	public void run(){
		try {
			Thread.currentThread().sleep(3000);
		} catch (InterruptedException e) {
		}
		System.out.println("MyThread running");
	}
}



public class ThreadTest{
	public static void main(String argv[]) {
		MyThread t = new MyThread();
		t.run();
		t.start();
		System.out.println("Thread Test");
	  }
}
```

#### 代码分析过程：

`MyThread t = new MyThread();`
创建了一个线程。
`t.run();`
调用`MyThread`对象的`run()`方法。
这是只有一个线程在运行就是主线程。
当主线程执行到了`run()`方法中的`sleep(3000);`时。
这是主线程处于冻结状态。程序并没有任何执行。
当3秒过后，主线程打印了  `MyThread running`。 `run()`方法执行结束。

`t.start();`
开启了t线程。
**有两种可能情况。**
1. 第一种情况:
主线程在只执行了`t.start()`后，还具有执行权，继续往下执行，
打印了`Thread Test`。主线程结束。
t线程获取执行权，调用自己的run方法。然后执行的`sleep(3000);`冻结3秒。
3秒后，打印MyThread running t线程结束，整个程序结束。

2. 第二种情况：
主线程执行到`t.start();`开启了t线程，t线程就直接获取到了执行权。
就调用自己的`run()`方法。
指定到`sleep(3000)`.t线程冻结3秒，这是t线程就是释放了执行权。
那么主线程开始执行打印了`Thread Test`，主线程结束。
等到3秒后，t线程打印`MyThread running` ，然后t线程结束。
程序结束。

### 总结


#### 线程间通信。
	等待/唤醒机制。

	也就是常见的生产者消费者问题。

	1. 当多个生产者消费者出现时，
	需要让获取执行权的线程判断标记。
	通过while完成。

	2. 需要将对方的线程唤醒。
	仅仅用notify，是不可以的。因为有可能出现只唤醒本方。
	有可能会导致，所有线程都等待。
	所以可以通过notifyAll的形式来完成 。

*这个程序有一个bug。就是每次notifyAll。都会唤醒本方。
可不可以只唤醒对方呢？*

**JDK1.5版本提供了一些新的对象，优化了等待唤醒机制。**

1. 将synchronized 替换成了Lock接口。
	将隐式锁，升级成了显示锁。
	**Lock**
		- 获取锁：lock();
		- 释放锁：unlock();注意：释放的动作一定要执行，所以通常定义在finally中。
		- 获取Condition对象：newCondition();
2. 将Object中的wait，notify，notifyAll方法都替换成了Condition的await，signal，signalAll。
	和以前不同是：一个同步代码块具备一个锁，该所以具备自己的独立wait和notify方法。
	现在是将wait，notify等方法，封装进一个特有的对象Condition，而一个Lock锁上可以有多个Condition对象。

``` java

	Lock lock = new ReentrantLock();

	Condition conA = lock.newCondition();
	Condition conB = lock.newCondition();

	con.await();//生产，，消费
	con.signal();生产


	set()
	{
		if(flag)
			conA.await();//生产者，
		code......;

		flag = true;
		conB.signal();
	}

	out()
	{
		if(!flag)
			conB.await();//消费者

		code....;
		flag = false;
		conA.signal();
	}


```
- wait和sleep的区别：
wait:释放cpu执行权，释放同步中锁。
sleep:释放cpu执行权，不释放同步中锁。

`synchronized(锁)
{
wait();
}`

#### 停止线程：
	**stop过时。**
	原理：run方法结束。run方法中通常定义循环，指定控制住循环线程即可结束。

	1. 定义结束标记。
	2. 当线程处于了冻结状态，没有执行标记，程序一样无法结束。
		这时可以循环，正常退出冻结状态，或者强制结束冻结状态。
		强制结束冻结状态：interrupt();目的是线程强制从冻结状态恢复到运行状态。
		但是会发生InterruptedException异常。



- 线程中一些常见方法：
	setDaemon(boolean):将线程标记为后台线程，后台线程和前台线程一样，开启，一样抢执行权运行，
	只有在结束时，有区别，当前台线程都运行结束后，后台线程会自动结束。

	join():什么意思？等待该线程结束。当A线程执行到了B的.join方法时，A就会处于冻结状态。
			A什么时候运行呢？当B运行结束后，A就会具备运行资格，继续运行。

	加入线程，可以完成对某个线程的临时加入执行。




**多线程重点:**
1. 多线程的创建的两种方式，以及区别。

2. 同步的特点。
  	同步的好处：
  	同步的弊端：
  	同步的前提：
  	同步的表现形式以及区别。
  	特例：static同步函数锁是哪一个。

	**死锁代码要求写的出来。**

3. 线程间通信，看以上总结。


4. wait和sleep，  `yield()`: 临时暂停，可以让线程是释放执行权。
`yield()`方法API:
`给调度程序的一个提示，当前线程愿意得到它当前的处理器的使用。调度程序可以自由地忽略这个提示。
产量是一个启发式的尝试，以改善线程之间的相对进展，否则将过度使用一个中央处理器。它的使用应结合详细的分析和基准，以确保它实际上有所需的效果。

使用这种方法是不恰当的。它可能是有用的调试或测试的目的，它可能有助于重现由于种族条件的错误。这也可能是有用的在设计并发控制结构如在java.util.concurrent.locks包的。
`
