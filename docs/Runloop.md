# Runloop

- **[Runloop的概念与作用](#runloop的概念与作用)**
- **[Runloop与线程的关系](#runloop与线程的关系)**
- **[PerformSelector的实现原理](#performSelector的实现原理)**
- **[Runloop有五种开启方法](#runloop有五种开启方法)**
- **[Runloop实际的应用](#runloop实际的应用)**


## Runloop的概念与作用
概念：  
一般来讲，一个线程一次只能执行一个任务，执行完成之后线程就会退出。但是有的时候我们需要线程能够一直``待命`` 随时处理事件而不退出，这就需要一个机制来完成这样的任务。
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
3. 节省CPU资源，优化程序性能: 程序运行起来时，当什么操作都没有的时候，Runloop就通知系统，现在没什么事情做，然后进行休息待命状态，这时候系统就会将其资源释放去做其他的事情。当有事情做，Runloop就会马上起来做事情。	

**Runloop,最重要的作用，就是用来管理线程，当线程的Runloop一开启，Runloop便开始对线程进行管理工作: 当线程执行完任务后，线程便会进入休眠状态,并且不退出，随时等待新的任务**
## Runloop与线程的关系
1. 每一条线程都有唯一与之对应的Runloop对象。
2. Runloop在第一次获取时创建，在线程结束时销毁
3. 主线程的Runloop系统默认启动，子线程的Runloop需要主动开启
4. Runloop 存储在一个全局的可变字典里，线程是 key ，Runloop 是 value 

> runloop 和线程是一一对应的，一个runloop对应一个核心的线程，为什么说是核心的，是因为runloop可以被嵌套，但是核心的只能有一个，他们的关系保存在一个全局的字典中。	
> runloop用来管理线程，当线程的runloop被开启后，线程会在执行完任务后进入休眠状态，有了任务就会被唤醒去执行任务。	
> runloop在第一次获取时被创建，在线程结束时被销毁	
	对主线程来说，runloop在程序一启动就默认创建好了。	
	对子线程来说，runloop是懒加载的，只有当我们使用的时候才会被创建，所以在子线程中使用定时器要注意：确保子线程的runloop被创建，不然定时器不会回调。		



## PerformSelector的实现原理
* 当调用 NSObject 的 performSelecter:afterDelay: 后，实际上其内部会创建一个 Timer 并添加到当前线程的 RunLoop 中。所以如果当前线程没有 RunLoop，则这个方法会失效。		
* 当调用 performSelector:onThread: 时，实际上其会创建一个 Timer 加到对应的线程去，同样的，如果对应线程没有 RunLoop 该方法也会失效。

## Runloop有五种开启方法	 
<details open>
  <summary>第一种直接使用[[NSRunLoop currentRunLoop] run],但是这种方式不能退出</summary>
  ```
  [[NSRunLoop currentRunLoop] run]
  ```	
  </details>	
  
  <details open>
  <summary>第二种直接使用[[NSRunLoop currentRunLoop] runUntilDate:],但是这种方式不能手动退出，只能等到UntilDate</summary>
  
  ```swift
  NSDate *date = [NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]];
  [[NSRunLoop currentRunLoop] runUntilDate:date];
  ```	
  </details>	
  
  <details open>
  <summary>第三种直接使用[[NSRunLoop currentRunLoop] runMode:beforeDate:],但是这种方式可以手动退出</summary>
  
  ```swift
  ChildThread *thread = [[ChildThread alloc] initWithBlock:^{
        NSLog(@"123");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer");
            CFRunLoopStop(CFRunLoopGetCurrent());
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//        NSDate *date = [NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]];
//        NSLog(@"%@",date);
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    }];
    [thread start];
  ```	
  </details>	


## AutoreleasePool
AutoreleasePool自动释放池,每一个自动释放池都是由一系列的```AutoreleasePoolPage```以**双向链表**的形式连接起来的，每个**AutoreleasePoolPage**的大小都是**4096**字节。

app启动后，苹果在主线程的Runloop里注册了两个Observer，其回调都是_wrapRunLoopWithAutoreleasePoolHandler()。

第一个Observer监听的时间是**Entry（即将进入Loop）**,其回调内会调用```_objc_autoreleasePoolPush()```创建自动释放池。其Order为 **-2147483647**，优先级最高，保证创建释放池发生在其他回调之前.

第二个Observer监听两个事件: **BeforeWaiting(准备进入休眠)**时调用```_objc_autoreleasePoolPop() ```和```_objc_autoreleasePoolPush()```释放旧的池并创建新池;**Exit(即将退出Loop)**时调用**_objc_autoreleasePoolPop()**来释放旧池。这个Observer的Order是**2147483647**，优先级最低，保证其释放池子发生在其所有回调之后。

## Runloop实际的应用
1. 子线程中NSTimer的使用
2. 后台常驻线程(后台下载的话)
3. 延时执行 performSelector:withObject:afterDelay:inModes
4. GCD Async Main Queue (GCD 中只有这个方法用到了Runloop)
5. 自动释放池 autoreleasepool
6. 处理App中的各种事件（比如触摸事件、定时器事件等）

