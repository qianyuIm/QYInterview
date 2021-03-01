# Runloop

- **[1.Runloop的概念与作用](#1.Runloop的概念与作用)**
- **[2.Runloop与线程的关系](#2.Runloop与线程的关系)**
- **[3.PerformSelector的实现原理](#3.PerformSelector的实现原理)**
- **[4.Runloop有五种开启方法](#4.Runloop有五种开启方法)**
- **[5.Runloop实际的应用](#5.Runloop实际的应用)**


## 1.Runloop的概念与作用
概念：  
一般来讲，一个线程一次只能执行一个任务，执行完成之后线程就会推出。但是有的时候我们需要线程能够一直``待命`` 随时处理事件而不退出，这就需要一个机制来完成这样的任务。
<details open>
  <summary>这样一种机制的代码逻辑如下</summary>

```swift
func loop() {	
		initialize();
		do {
			var message = get_next_message();
			process_message(message);
		} while (message != quit);
	}
```
这种模型通常被称为[Event Loop](
http://en.wikipedia.org/wiki/Event_loop),在iOS中被称之为Runloop。这中模型的关键点在于:如何管理事件/消息,如何让线程在没有处理消息时休眠以避免资源占用、在有消息到来时立即被唤醒。例如：一个应用程序放到那里，不进行操作就像静止休息一样，点击按钮，就有响应，就像``随时待命``一样，这就是Runloop的功劳。  
所以，Runloop实际上就是一个对象，这个对象管理了其需要处理的事件和消息，并提供了一个入口函数来执行Runloop的逻辑。线程执行了这个函数后，就会一直处于这个函数内部"接受消息 -> 等待 -> 处理"的循环中，直到这个循环结束(比如传入quit的消息),函数返回。	
作用:		
1. 保持程序的持续运行: 例如程序一启动就会开一个主线程,主线程一开起来就会跑一个主线程对应的Runloop,Runloop保证主线程不会被销毁，也就是保证了程序的持续运行。	
2. 处理App中的各种事件(比如: 触摸事件，定时器事件，Selector事件等)	
3. 节省CPU资源，优化程序性能: 程序运行起来是，当什么操作都没有的时候，Runloop就通知系统，现在没什么事情做，然后进行休息待命状态，这时候系统就会将其资源释放去做其他的事情。当有事情做，Runloop就会马上起来做事情。	

**Runloop,最重要的作用，就是用来管理线程，当线程的Runloop一开启，Runloop便开始对线程进行管理工作: 当线程执行完任务后，线程便会进入休眠状态,并且不退出，随时等待新的任务**
## 2.Runloop与线程的关系
1. 每一条线程都有唯一与之对应的Runloop对象。
2. Runloop在第一次获取时创建，在线程结束时销毁
3. 主线程的Runloop系统默认启动，子线程的Runloop需要主动开启
4. Runloop 存储在一个全局的可变字典里，线程是 key ，Runloop 是 value 

## 3.PerformSelector的实现原理
* 当调用 NSObject 的 performSelecter:afterDelay: 后，实际上其内部会创建一个 Timer 并添加到当前线程的 RunLoop 中。所以如果当前线程没有 RunLoop，则这个方法会失效。		
* 当调用 performSelector:onThread: 时，实际上其会创建一个 Timer 加到对应的线程去，同样的，如果对应线程没有 RunLoop 该方法也会失效。

## 4.Runloop有五种开启方法	 
<details open>
  <summary>第一种直接使用[[NSRunLoop currentRunLoop] run],但是这种方式不能退出</summary>
  ```
  [[NSRunLoop currentRunLoop] run]
  ```		
  
## 5.Runloop实际的应用

