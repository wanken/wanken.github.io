---
title: JavaReview-day14-集合框架[1]
date: 2018-01-22 17:39:21
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---

# 集合框架

## 集合框架图
![](/images/post_images/20180122-Collection.jpg)
![](/images/post_images/20180122-Collection-simple.jpg)

## Collection

Collection定义了集合框架的共性功能。
1. 添加
	add(e);
	addAll(collection);

2. 删除
	remove(e);
	removeAll(collection);
	clear();

3. 判断。
	contains(e);
	isEmpty();

4. 获取
	iterator();
	size();

5. 获取交集。
	retainAll();

6. 集合变数组。
	toArray();



- add方法的参数类型是Object。以便于接收任意类型对象。

-  集合中存储的都是对象的引用(地址)


**什么是迭代器呢？**
其实就是集合的取出元素的方式。
如同抓娃娃游戏机中的夹子。

迭代器是取出方式，会直接访问集合中的元素。
所以将迭代器通过内部类的形式来进行描述。
通过容器的iterator()方法获取该内部类的对象。







```java
import java.util.*;

class  CollectionDemo
{
	public static void main(String[] args)
	{
		method_get();
	}
	public static void method_get()
	{
		ArrayList al = new ArrayList();
		//1，添加元素。
		al.add("java01");//add(Object obj);
		al.add("java02");
		al.add("java03");
		al.add("java04");
		/*
		Iterator it = al.iterator();//获取迭代器，用于取出集合中的元素。
		while(it.hasNext())
		{
			sop(it.next());
		}
		*/
		for(Iterator it = al.iterator(); it.hasNext() ; )
		{
			sop(it.next());
		}
	}

	public static void method_2()
	{
		ArrayList al1 = new ArrayList();

		al1.add("java01");
		al1.add("java02");
		al1.add("java03");
		al1.add("java04");
		ArrayList al2 = new ArrayList();

		al2.add("java03");
		al2.add("java04");
		al2.add("java05");
		al2.add("java06");

		//al1.retainAll(al2);//去交集，al1中只会保留和al2中相同的元素。
		al1.removeAll(al2);
		sop("al1:"+al1);
		sop("al2:"+al2);

	}

	public static void base_method()
	{
		//创建一个集合容器。使用Collection接口的子类。ArrayList
		ArrayList al = new ArrayList();

		//1，添加元素。
		al.add("java01");//add(Object obj);
		al.add("java02");
		al.add("java03");
		al.add("java04");

		//打印原集合。
		sop("原集合:"+al);

		//3，删除元素。
		//al.remove("java02");
		//al.clear();//清空集合。

		//4，判断元素。
		sop("java03是否存在:"+al.contains("java03"));
		sop("集合是否为空？"+al.isEmpty());

		//2，获取个数。集合长度。
		sop("size:"+al.size());

		//打印改变后的集合。
		sop(al);

	}

	public static void sop(Object obj)
	{
		System.out.println(obj);
	}
}
```

## List

### Vector

枚举就是Vector特有的取出方式。
发现枚举和迭代器很像。
其实枚举和迭代是一样的。

因为枚举的名称以及方法的名称都过长。
所以被迭代器取代了。
枚举郁郁而终了。

```java

import java.util.*;

class VectorDemo
{
	public static void main(String[] args)
	{
		Vector v = new Vector();

		v.add("java01");
		v.add("java02");
		v.add("java03");
		v.add("java04");

		Enumeration en = v.elements();

		while(en.hasMoreElements())
		{
			System.out.println(en.nextElement());
		}
	}
}
```


### LinkedList

使用LinkedList模拟一个堆栈或者队列数据结构。

堆栈：先进后出  如同一个杯子。
队列：先进先出 First in First out  FIFO 如同一个水管。

```java
import java.util.*;
class DuiLie
{
	private LinkedList link;

	DuiLie()
	{
		link = new LinkedList();
	}

	public void myAdd(Object obj)
	{
		link.addFirst(obj);
	}
	public Object myGet()
	{
		return link.removeFirst();
	}
	public boolean isNull()
	{
		return link.isEmpty();
	}

}



class  LinkedListTest
{
	public static void main(String[] args)
	{
		DuiLie dl = new DuiLie();
		dl.myAdd("java01");
		dl.myAdd("java02");
		dl.myAdd("java03");
		dl.myAdd("java04");

		while(!dl.isNull())
		{
			System.out.println(dl.myGet());
		}
	}
}
```

### ArrayList

```java
import java.util.*;
/*
去除ArrayList集合中的重复元素。
*/
class ArrayListTest
{
	public static void sop(Object obj)
	{
		System.out.println(obj);
	}
	public static void main(String[] args)
	{
		ArrayList al = new ArrayList();

		al.add("java01");
		al.add("java02");
		al.add("java01");
		al.add("java02");
		al.add("java01");
    //al.add("java03");
		/*
		在迭代时循环中next调用一次，就要hasNext判断一次。
		Iterator it = al.iterator();

		while(it.hasNext())
		{
			sop(it.next()+"...."+it.next());
		}
		*/

		sop(al);
		al = singleElement(al);
		sop(al);
	}

	public static ArrayList singleElement(ArrayList al)
	{
		//定义一个临时容器。
		ArrayList newAl = new ArrayList();

		Iterator it = al.iterator();

		while(it.hasNext())
		{
			Object obj = it.next();

			if(!newAl.contains(obj))
				newAl.add(obj);
		}
		return newAl;
	}
}
```

### ArrayList练习:

将自定义对象作为元素存到ArrayList集合中，并去除重复元素。
比如：存人对象。同姓名同年龄，视为同一个人。为重复元素。


思路:
1. 对人描述，将数据封装进人对象。
2. 定义容器，将人存入。
3. 取出。



List集合判断元素是否相同，依据是元素的equals方法。

```java

import java.util.*;
class Person
{
	private String name;
	private int age;
	Person(String name,int age)
	{
		this.name = name;
		this.age = age;
	}

	public boolean equals(Object obj)
	{

		if(!(obj instanceof Person))
			return false;

		Person p = (Person)obj;
		//System.out.println(this.name+"....."+p.name);

		return this.name.equals(p.name) && this.age == p.age;
	}

	public String getName()
	{
		return name;
	}
	public int getAge()
	{
		return age;
	}
}
class ArrayListTest2
{
	public static void sop(Object obj)
	{
		System.out.println(obj);
	}
	public static void main(String[] args)
	{
		ArrayList al = new ArrayList();

		al.add(new Demo());

		al.add(new Person("lisi01",30));//al.add(Object obj);//Object obj = new Person("lisi01",30);
		//al.add(new Person("lisi02",32));
		al.add(new Person("lisi02",32));
		al.add(new Person("lisi04",35));
		al.add(new Person("lisi03",33));
		//al.add(new Person("lisi04",35));


		//al = singleElement(al);

		sop("remove 03 :"+al.remove(new Person("lisi03",33)));//remove方法底层也是依赖于元素的equals方法。


		Iterator it = al.iterator();


		while(it.hasNext())
		{
			Person p = (Person)it.next();
			sop(p.getName()+"::"+p.getAge());
		}
	}


	public static ArrayList singleElement(ArrayList al)
	{
		//定义一个临时容器。
		ArrayList newAl = new ArrayList();

		Iterator it = al.iterator();

		while(it.hasNext())
		{
			Object obj = it.next();

			if(!newAl.contains(obj))
				newAl.add(obj);

		}

		return newAl;
	}
}
```

### 练习2

对字符串排序。
"zxcvbasdfg"
思路：
1. 字符串变数组。
2. 数组排序。
3. 数组变字符串。

```java
import java.util.*;
class  Test
{
	public static void main(String[] args)
	{
		String str = "zxcvbasdfg";

//		char[] arr = str.toCharArray();
//		Arrays.sort(arr);
//		System.out.println(new String(arr));
//		str = sortString(str);
//		System.out.println(str);
	}

	public static String sortString(String str)
	{
		char[] arr = stringToArray(str);

		sort(arr);

		return arrayToString(arr);
	}

	private static char[] stringToArray(String str)
	{
		return str.toCharArray();
	}

	private static void sort(char[] arr)
	{
		for(int x=0; x<arr.length-1; x++)
		{
			for(int y=x+1; y<arr.length; y++)
			{
				if(arr[x]>arr[y])
				{
					swap(arr,x,y);
				}
			}
		}
	}
	private static void swap(char[] arr,int x,int y)
	{
		char temp = arr[x];
		arr[x] = arr[y];
		arr[y] = temp;
	}

	private static String arrayToString(char[] arr)
	{
		return new String(arr);
	}
}
```
