---
title: JavaReview-day07
date: 2017-12-18 19:14:57
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview
---

## 继承

特点:
 - 提高了代码的复用性;
 - 让类与类之间产生了关系. 有了这个关系, 才有了多态的特性;
 - Java中只支持单继承, 不支持多继承, 因为继承容易带来安全隐患


### 重写(覆盖)

- 当子类中出现和父类一模一样的函数时, 当子类对象调用该函数, 会运行子类函数的内容, 如同父
类的函数被覆盖一样.
- 当子类继承父类, 沿袭了父类的功能, 到子类中, 但是子类具备该功能, 但是功能的内容却和父类
不一致, 这时没有必要定义新功能, 而是使用覆盖, 只保留父类的功能定义, 并重写功能内容.

1. 子类覆盖父类, 必须保证子类权限大于等于父类权限, 才可以覆盖, 否则编译失败.
2. 静态只能覆盖静态
3. 如果父类中的方法权限为`private`, 则子类无法重写该方法.


### 重写和重载的区别

- 重载: 只看同名函数的参数列表
- 重写: 子父类方法要一模一样

### 子父类中构造函数的特点

```java
  class Father{
    Father(){
      System.out.println("Father run |");
    }
  }
  class Son extends Parent {
    Sun(){
      // super();
      System.out.println("Son run |");
    }
  }
  class Demo{
    public static void main(String[] args) {
      Son s = new Son();
    }
  }

```
以上程序的运行结果为 `Father run | Son run |` ;

- 子类中的构造函数第一行会隐式的存在一句 `super()` 默认调用父类中默认的构造方法;
- 如果父类中没有默认的构造方法, 可以在子类构造方法中的第一行通过 `super(xxx)`
手动的来指定父类中特定的构造函数;

#### 注意

- `super()` 语句一定是在子类构造函数的第一行

```java
  public class TestExtend {

    public static void main(String[] args) {
        Son s = new Son(4);
    }
  }
  class Father{
    public int m;
    Father(){
        m = 2;
        System.out.println("Father Run");
    }
    Father(int x){
        m = 6;
        System.out.println("TTTT");
    }
  }
  class Son extends Father{
    Son(){
      this(4);
      System.out.println(this.m);
      System.out.println("Son run");
    }
    Son(int x){
      this();
      System.out.println("MMMM");
    }
}

```

- 以上代码会出现编译错误, 错误原因为 `recursive constructor invocation`意思为
'<font color='red'>构造器中出现了递归调用, 这是不被允许的</font>';

### final 关键字

- final: 最终. 作为一个修饰符;

#### 作用及特点

1. 可以修饰类, 函数, 变量;
2. 被 `final` 修饰的类不可以被继承; 为了避免被继承, 被子类复写功能;
3. 被 `final` 修饰的方法不可以被复写;
4. 被 `final` 修饰的变量是一个常量且只能赋值一次; `final` 既可以修饰成员变量, 又可以
修饰局部变量, 当在描述事物时, 一些数据的值是固定的, 那么这时为了增强阅读性, 都给这些值
起个名字, 方便与阅读;
5. 内部类定义在类中的局部位置上时, 只能访问局部被 `final` 修饰的局部变量;


### 抽象类(abstract)

- 特点:
  1. 抽象方法一定定义在抽象类中;
  2. 抽象方法和抽象类都必须被 `abstract` 关键字修饰;
  3. 抽象类不可以用 `new` 创建对象, 因为调用抽象方法没有意义;
  4. 抽象类中的方法要被使用, 必须由子类复写其所有的抽象方法后, 建立子类对象调用, **如
  果子类只覆盖了部分抽象方法, 那么该子类还是一个抽象类**

- 抽象类和一般类的区别:
  1. 抽象类比一般类多了个抽象函数, 就是在类中可以定义抽象方法;
  2. 抽象类不可以实例化;

- 特殊: 抽象类中可以不定义抽象方法, 可以使该类不创建对象;
- `abstract` 只可以修饰类和方法, 不能修饰变量;

### 接口

 **接口定义时的格式特点**:
- 接口转中常见定义: 常量, 抽象方法;
- 接口中的成员变量都有固定修饰符:
	1. 常量:`public static final`
	2. 方法:`public abstract`  
- 接口是不可以创建对象的, 因为接口中有抽象方法
- 接口需要被子类实现子类对接口的抽象方法全部覆盖后, 子类才可以实例化
- 接口可以被类多实现, 也是对不支持多继承的转换形式, Java支持多实现;

**接口与接口之间可以实现多继承**
```java
interface A{
	void showA();
}
interface B extends A {
	void showB();
}

interface C extends B {
	void showC();
}

class D implements C {
	public void showA(){};
	public void showB(){};
	public void showC(){};

}
```

<font color='red'>**注意**:</font>
接口与接口之间的继承中, 被继承的接口中不能含有名字相同, 返回值不同的方法;
```java
```java
interface A{
	void showA();
	int test();
}
interface B {
	void showB();
	//void test();//错误的写法
}

interface C extends A, B {
	void showC();
}

class D implements C {
	public void showA(){};
	public void showB(){};
	public void showC(){};

}
```
