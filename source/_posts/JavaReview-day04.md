---
title: JavaReview-day04
date: 2017-11-28 16:14:34
tags:
  - Java
categories:
  - JavaReview
type:
  - JavaReview

---

### 数组

      1. 数据类型分类: 基本数据类型, 引用数据类型
      2. Java 程序在运行时,需要在内存中分配空间, 为了提高运算效率, 又对空间进行了不同区域的划分 因为每一片区域都有特定的处理数据的方式和内存管理方式 共分为五个区域: 栈内存, 堆内存, 方法区, 本地方法区, 寄存器

    - 栈内存:用于存储局部变量, 当数据使用完, 所占空间会自动释放;
    - 堆内存:
      1. 数组和对象,通过 new 建立的实例都存放在堆内存中;
      2. 每一个实体都有内存地址值;
      3. 实体中的变量都有默认的初始化值
      4. 实体不再被使用时, 会在不确定的时间内被垃圾回收器回收

### 数组的定义方式

        1. int[] arr = new int[5]; (推荐写法)
        2. int arr[] = new int[5]; (与第一种意义相同)
        3. int[] arr = new int[]{1, 2, 3, 4, 5}; (静态初始化方式)
        4. int[] arr = {1, 2, 3, 4, 5} (第三种的简化格式)

#### 数组排序
##### 选择排序

```
        public void selectSort(int[] arr){
            for(int x = 0; x < arr.length-1; x++){
                for(int y = x + 1; y < arr.length; y++){
                    if(arr[x] > arr[y]){
                        int temp = arr[x];
                        arr[x] = arr[y];
                        arr[y] = temp;
                    }
                }
            }
        }
```
> 说明: 选择排序是用当前元素与其他所有元素比较, 如果符合条件,就交换位置

##### 冒泡排序
```  
        public void bubbleSort(int[] arr){
            for(int x = 0; x < arr.length; x ++){
                for(int y = 0; y < arr.length - x - 1; y ++){
                    if(arr[y] > arr[y + 1]){
                        int temp = arr[y];
                        arr[y] = arr[y + 1];
                        arr[y + 1] = temp;

                    }
                }
            }
        }
```
##### 说明: 冒泡排序是用相邻的元素进行比较, 如果符合条件,就交换位置
##### 使用 java.util包中的 Array.sort(arr); 可以进行排序数组

- 将数组交换的方法进行封装
```
        public void swap(int[] arr, int a, int b){
            int temp = arr[a];
            arr[b] = arr[a];
            arr[b] = temp;
        }
```
##### 使用异或方式实现

```
        public void swap1(int arr, int a, int b){
            arr[b] = arr[b] ^ arr[a];
            arr[a] = arr[b] ^ arr[a];
            arr[b] = arr[b] ^ arr[a];
        }
```

#### 折半查找
##### 第一种方式
  ```
     public int halfSearch (int[] arr, int key){
       int min = 0;
       int max = arr.length - 1;
       int mid = (min + max)/2;
       while(arr[mid] != key){
         if(key < arr[mid]){
           max = mid - 1;
         }else if(key > arr[mid]){
           min = mid + 1;
         }
         mid = (min + max)/2;
       }
       return mid;
     }
```
##### 第二种方式
   ```
     public int halfSearch2(int arr[], int key){
       int min = 0;
       int max = arr.length;
       while(min <= max){
          mid = (min + max) >> 1;
          if(key > arr[mid]){
            min = mid + 1;
          }else if(key < arr[mid]){
            max = mid -1;
          }else{
            return mid;
          }
          return -1;

       }

     }
   ```


> 面试题:将一个数字插入一个有序数组, 插入后,保证数组有序;

- 思路: 通过折半查找, 找到所插入数组的下标, 如果数组中存在与插入值相同的值,则在该元素之前插入

##### 十进制转二进制
  ```
    public void decimalToBinary() {
            int num = 8;
            StringBuffer sb = new StringBuffer();
            while (num > 0) {
                sb.append(num % 2);
                num = num / 2;
            }
            System.out.println(sb.reverse());
        }
  ```

##### 十进制转十六进制
 - 第一种方式

```
  public void decimalToHexadecimal() {
        int num = 60;
        StringBuffer stringBuffer = new StringBuffer();
        for (int x = 0; x < 8; x++) {
            int temp = num & 15;
            if (temp > 9) {
                stringBuffer.append((char) (temp - 10 + 'A'));
            } else {
                stringBuffer.append(temp);
            }
            num = num >>> 4;
        }
        System.out.println(stringBuffer.reverse());
    }
```
**二维数组的定义方法**
```
  int[][]
```
