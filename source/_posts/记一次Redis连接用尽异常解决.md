---
title: 记一次Redis连接用尽异常解决
date: 2017-12-01 11:04:30
tags: [Redis, Java, Jedis]
type: [Redis, Jedis]
---

> 不知怎么突然jedis出现 "Could not get a resource from the pool" 错误,错误原因是连接池中的链接用尽

## 解决方法:

```
redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource from the pool  
    at redis.clients.util.Pool.getResource(Pool.java:22)  
    at com.derbysoft.jredis.longkeytest.BorrowObject.run(BorrowObject.java:22)  
    at java.lang.Thread.run(Thread.java:662)  
Caused by: java.util.NoSuchElementException: Timeout waiting for idle object  
    at org.apache.commons.pool.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:1134)  
    at redis.clients.util.Pool.getResource(Pool.java:20)  
    ... 2 more
```

1. 增加 Jedis 的活动连接数:

```
<bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
		<!-- 最大连接数 -->
		<property name="maxTotal" value="300" />
		<!-- 最大空闲连接数 -->
		<property name="maxIdle" value="50" />
		<!-- 每次释放连接的最大数目 -->
		<property name="numTestsPerEvictionRun" value="1024" />
		<!-- 释放连接的扫描间隔（毫秒） -->
		<property name="timeBetweenEvictionRunsMillis" value="30000" />
		<!-- 连接最小空闲时间 -->
		<property name="minEvictableIdleTimeMillis" value="1800000" />
		<!-- 连接空闲多久后释放, 当空闲时间>该值 且 空闲连接>最大空闲连接数 时直接释放 -->
		<property name="softMinEvictableIdleTimeMillis" value="10000" />
		<!-- 获取连接时的最大等待毫秒数,小于零:阻塞不确定的时间,默认-1 -->
		<property name="maxWaitMillis" value="1500" />
		<!-- 在获取连接的时候检查有效性, 默认false -->
		<property name="testOnBorrow" value="true" />
		<!-- 在空闲时检查有效性, 默认false -->
		<property name="testWhileIdle" value="true" />
		<!-- 连接耗尽时是否阻塞, false报异常,ture阻塞直到超时, 默认true -->
		<property name="blockWhenExhausted" value="false" />
	</bean>
```
将最大连接数增加到 300, 但是错误仍然出现, 检查代码发现, 连接用完后并没有释放.

- 使用 **jedis.close();** 释放资源后问题解决, 修改前的代码:
```
public String get(String key) {
     Jedis jedis = jedisPool.getResource();
     String get = jedis.get(key);
     return get;
 }
```
修改后的代码:
```
public String get(String key) {
     Jedis jedis = jedisPool.getResource();
     String get = jedis.get(key);
     jedis.close();
     return get;
 }
```
