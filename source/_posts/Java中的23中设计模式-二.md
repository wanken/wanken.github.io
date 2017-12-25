---
title: Java中的23中设计模式(二)
date: 2017-12-25 08:27:27
tags:
  - Java
  - 设计模式
categories:
  - Java
  - 设计模式
type:
  - Java
  - 设计模式
---

>本文转载自[http://blog.csdn.net/zhangerqing](http://blog.csdn.net/zhangerqing)

我们接着讨论设计模式，上篇文章我讲完了5种创建型模式，这章开始，我将讲下7种结构型模式：适
配器模式、装饰模式、代理模式、外观模式、桥接模式、组合模式、享元模式。其中对象的适配器模
式是各种模式的起源，我们看下面的图：

![](/images/post_images/20171225_01.png)
## 6. 适配器模式(Adapter)
	适配器模式将某个类的接口转换成客户端期望的另一个接口表示，目的是消除由于接口不匹配所造
成的类的兼容性问题。主要分为三类：类的适配器模式、对象的适配器模式、接口的适配器模式。

首先，我们来看看类的适配器模式，先看类图：
![](/images/post_images/20171225_02.png)

核心思想就是：有一个Source类，拥有一个方法，待适配，目标接口时Targetable，通过Adapter
类，将Source的功能扩展到Targetable里，看代码：

```java
public class Source {  

    public void method1() {  
        System.out.println("this is original method!");  
    }  
}  
```

```java
public interface Targetable {  

    /* 与原类中的方法相同 */  
    public void method1();  

    /* 新类的方法 */  
    public void method2();  
}  

```

```java
public class Adapter extends Source implements Targetable {  

    @Override  
    public void method2() {  
        System.out.println("this is the targetable method!");  
    }  
}  
```
Adapter类继承Source类，实现Targetable接口，下面是测试类:

```java
public class AdapterTest {  

    public static void main(String[] args) {  
        Targetable target = new Adapter();  
        target.method1();  
        target.method2();  
    }  
}
```
输出:
`this is original method!
this is the targetable method!`
这样Targetable接口的实现类就具有了Source类的功能。

<font color='#B83B5E'>**对象的适配器模式**</font>

基本思路和类的适配器模式相同，只是将Adapter类作修改，这次不继承Source类，而是持有Source
类的实例，以达到解决兼容性的问题。看图:
![](/images/post_images/20171225_03.png)

只需要修改Adapter类的源码即可:
```java
public class Wrapper implements Targetable {  

    private Source source;  

    public Wrapper(Source source){  
        super();  
        this.source = source;  
    }  
    @Override  
    public void method2() {  
        System.out.println("this is the targetable method!");  
    }  

    @Override  
    public void method1() {  
        source.method1();  
    }  
}  
```
测试类:

```java
public class AdapterTest {  

    public static void main(String[] args) {  
        Source source = new Source();  
        Targetable target = new Wrapper(source);  
        target.method1();  
        target.method2();  
    }  
}
```
输出与第一种一样，只是适配的方法不同而已。

第三种适配器模式是<font color='#B83B5E'>**接口的适配器模式**</font>，接口的适配器是
这样的：有时我们写的一个接口中有多个抽象方法，当我们写该接口的实现类时，必须实现该接口
的所有方法，这明显有时比较浪费，因为并不是所有的方法都是我们需要的，有时只需要某一些，
此处为了解决这个问题，我们引入了接口的适配器模式，借助于一个抽象类，该抽象类实现了该接
口，实现了所有的方法，而我们不和原始的接口打交道，只和该抽象类取得联系，所以我们写一个
类，继承该抽象类，重写我们需要的方法就行。看一下类图:
![](/images/post_images/20171225_04.png)

这个很好理解，在实际开发中，我们也常会遇到这种接口中定义了太多的方法，以致于有时我们在
一些实现类中并不是都需要。看代码:
```java
public interface Sourceable {  

    public void method1();  
    public void method2();  
}  
```
抽象类Wrapper2:
```java
public abstract class Wrapper2 implements Sourceable{  

    public void method1(){}  
    public void method2(){}  
}  
```
```java
public class SourceSub1 extends Wrapper2 {  
    public void method1(){  
        System.out.println("the sourceable interface's first Sub1!");  
    }  
}
```
```java
public class SourceSub2 extends Wrapper2 {  
    public void method2(){  
        System.out.println("the sourceable interface's second Sub2!");  
    }  
}  
```
```java
public class WrapperTest {  

    public static void main(String[] args) {  
        Sourceable source1 = new SourceSub1();  
        Sourceable source2 = new SourceSub2();  

        source1.method1();  
        source1.method2();  
        source2.method1();  
        source2.method2();  
    }  
}
```
测试输出：
`the sourceable interface's first Sub1!
the sourceable interface's second Sub2!`
达到了我们的效果！
讲了这么多，总结一下三种适配器模式的应用场景：
类的适配器模式：当希望将<font color='#F08A5D'>一个类</font>转换成满足<font color='#F08A5D'>另一个新接口</font>的类时，可以使用类的适配器模式，创
建一个新类，继承原有的类，实现新的接口即可。
对象的适配器模式：当希望将一个对象转换成满足另一个新接口的对象时，可以创建一个Wrapper类
，持有原类的一个实例，在Wrapper类的方法中，调用实例的方法就行。
接口的适配器模式：当不希望实现一个接口中所有的方法时，可以创建一个抽象类Wrapper，实现所
有方法，我们写别的类的时候，继承抽象类即可。

## 7. 装饰模式（Decorator）

顾名思义，装饰模式就是给一个对象增加一些新的功能，而且是动态的，要求装饰对象和被装饰对
象实现同一个接口，装饰对象持有被装饰对象的实例，关系图如下:
![](/images/post_images/20171225_04.png)

Source类是被装饰类，Decorator类是一个装饰类，可以为Source类动态的添加一些功能，代码如下:
```java
public interface Sourceable {  
    public void method();  
}  
```
```java
public class Source implements Sourceable {  

    @Override  
    public void method() {  
        System.out.println("the original method!");  
    }  
}  
```

```java
public class Decorator implements Sourceable {  

    private Sourceable source;  

    public Decorator(Sourceable source){  
        super();  
        this.source = source;  
    }  
    @Override  
    public void method() {  
        System.out.println("before decorator!");  
        source.method();  
        System.out.println("after decorator!");  
    }  
}  
```

测试类:
```java
public class DecoratorTest {  

    public static void main(String[] args) {  
        Sourceable source = new Source();  
        Sourceable obj = new Decorator(source);  
        obj.method();  
    }  
}  
```
输出：
`before decorator!
the original method!
after decorator!`

- 装饰器模式的应用场景：
1. 需要扩展一个类的功能。
2. 动态的为一个对象增加功能，而且还能动态撤销。(继承不能做到这一点，继承的功能是静态的，不能动态增删。)

- 缺点：产生过多相似的对象，不易排错！

## 8. 代理模式(Proxy)
其实每个模式名称就表明了该模式的作用，代理模式就是多一个代理类出来，替原对象进行一些操
作，比如我们在租房子的时候回去找中介，为什么呢？因为你对该地区房屋的信息掌握的不够全面
，希望找一个更熟悉的人去帮你做，此处的代理就是这个意思。再如我们有的时候打官司，我们需
要请律师，因为律师在法律方面有专长，可以替我们进行操作，表达我们的想法。先来看看关系图:
![](/images/post_images/20171225_04.png)
根据上文的阐述，代理模式就比较容易的理解了，我们看下代码:

```java
public interface Sourceable {  
    public void method();  
}  
```

```java
public class Source implements Sourceable {  

    @Override  
    public void method() {  
        System.out.println("the original method!");  
    }  
}  
```

```java
public class Proxy implements Sourceable {  

    private Source source;  
    public Proxy(){  
        super();  
        this.source = new Source();  
    }  
    @Override  
    public void method() {  
        before();  
        source.method();  
        atfer();  
    }  
    private void atfer() {  
        System.out.println("after proxy!");  
    }  
    private void before() {  
        System.out.println("before proxy!");  
    }  
}  
```
测试类:
```java
public class ProxyTest {  

    public static void main(String[] args) {  
        Sourceable source = new Proxy();  
        source.method();  
    }  

}
```
输出：
`before proxy!
the original method!
after proxy!`

- **代理模式的应用场景:**
如果已有的方法在使用的时候需要对原有的方法进行改进，此时有两种办法：
1. 修改原有的方法来适应。这样违反了“对扩展开放，对修改关闭”的原则。
2. 就是采用一个代理类调用原有的方法，且对产生的结果进行控制。这种方法就是代理模式。
使用代理模式，可以将功能划分的更加清晰，有助于后期维护！

## 9、外观模式(Facade)
