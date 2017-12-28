---
title: maven管理SSM时xml和properties文件丢失异常
date: 2017-12-28T18:52:23.000Z
tags:
  - Spring
  - Exception
categories:
  - Exception
type:
  - Exception
---

# classpath resource [com/qinkangdeid/mapping/] cannot be resolved to URL because it does not exist 和 org.apache.ibatis.binding.BindingException: Invalid bound statement (not found)异常解决

项目结构如图所示: ![](/images/post_images/20171228ResourceException.jpg)

```xml
<build>
  <resources>
      <resource>
        <directory>src/main/java</directory>
          <includes>
            <include>**/*.properties</include>
            <include>**/*.xml</include>
          </includes>
          <filtering>false</filtering>
        </resource>
        <resource>
          <directory>src/main/resources</directory>
          <includes>
            <include>**/*.properties</include>
            <include>**/*.xml</include>
          </includes>
          <filtering>false</filtering>
        </resource>
      </resources>
</build>
```
如上图所示, 将com.bobo.mapper和resource目录配置到pom文件的bulid中即可
