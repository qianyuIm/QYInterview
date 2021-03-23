# AutoreleasePool
全局异常断点 
> objc_autoreleasePoolPop

```自动释放池```是OC中的一种```内存自动回收机制```,在`MRC`中可以用`AutoReleasePool 来延迟内存的释放`,在`ARC`中可以`用AutoReleasePool将对象添加到最近的自动释放池`,`不会立即释放`,会等到 `runloop休眠`或者超出`autoReleasepool作用域`之后才会`被释放`。

在程序启动的时候系统在主线程的`runloop`中注册了两个`Observer `，回调都是 `_wrapRunLoopWithAutoreleasePoolHandler(iOS 14之下),_runLoopObserverCallout(iOS 14以上)`(可以打断点` po [NSRunLoop currentRunLoop]`)查看。

第一个`Observer`监听的事件是`Entry `(即将进入loop时)，内部回调会调用`_objc_autoreleasePoolPush()`创建自动释放池。其`order`优先级为 **-2147483647(2的32次方减一)** ,优先级最高，保证创建自动释放池发生在所有回调之前。

第二个`Observer`监听两个事件: `kCFRunLoopBeforeWaiting `准备进入睡眠, `kCFRunLoopExit`即将退出`RunLoop `。在`kCFRunLoopBeforeWaiting `事件时调用`_objc_autoreleasePoolPop()`和`_objc_autoreleasePoolPush()`释放旧的自动释放池并创建新的自动释放池。在`kCFRunLoopExit `事件时调用`_objc_autoreleasePoolPop()`来释放自动释放池,同时这个`Observer`的`order`为 **2147483647(2的32次方减一)**优先级最低，保证其释放自动释放池的操作发生在其他回调之后。

##  AutoreleasePool在什么时候释放
1. 在没有手动增加`AutoreleasePool `的情况下，`Autorelease `对象都是在当前`runloop`迭代结束时释放，而它能够释放的原因就是系统在`runloop`的每个迭代过程中都加入了自动释放池的`push`和`pop`操作。
2. 手动添加的`AutoreleasePool`在其作用域{}消失时释放。因为AutoreleasePool实际就是一个`__AtAutoreleasePool`的结构体包含构造函数和析构函数，在其作用域结束后会自动调用析构函数

> `clang`命令为：
> `xcrun -sdk iphonesimulator clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp`

```
struct __AtAutoreleasePool {
    // 构造函数
  __AtAutoreleasePool() {
      atautoreleasepoolobj = objc_autoreleasePoolPush();
  }
    // 析构函数
  ~__AtAutoreleasePool() {
      objc_autoreleasePoolPop(atautoreleasepoolobj);
  }
  void * atautoreleasepoolobj;
};
```
### 测试

```
struct QYTest {
    QYTest() {
        index = 10;
        NSLog(@"%d",index);
    }
    ~QYTest() {
        index = 20;
        NSLog(@"%d",index);
    }
    int index;
};
在.mm中调用 
	NSLog(@"开始");
    {
        QYTest test;
    }
    NSLog(@"结束");
```

> 

## 自动释放池原理即AutoreleasePool原理
* 1. `自动释放池`的`本质`是一个`AutoreleasePoolPage的结构体对象`,是一个`栈结构存储的页`，每一个`AutoreleasePoolPage`都是`以双向链表的形式连接`。
*  2. ` 页的栈底`是一个`56`字节大小的`空占位符`，`一页总大小为4096字节`
*  3. 只有第一页`有哨兵对象`，`最多存储504个对象`，从`第二页`开始`最多存储505个对象`
* 4. `自动释放池`的`压栈`和`出栈`主要是通过`结构体的构造函数`和`析构函数`调用底层的`objc_autoreleasePoolPush `和`objc_autoreleasePoolPop `, 实际上是调用`AutoreleasePoolPage `的`push`和`pop`两个方法。
* 5. 每次`调用push操作`其实都是`创建`一个新的`AutoreleasePoolPage`，而`AutoreleasePoolPage`的具体操作就是`插入一个POOL_BOUNDARY`，并返回插入`POOL_BOUNDARY 的内存地址`。而`push`内部调用`autoreleaseFast `方法处理，主要有以下三种情况:
	* 当`page`存在，且`不满`时，调用`add方法`将`对象添加至page的next指针处` ,` 并next递增`。
	* 当`page`存在，且`已满`时，调用`autoreleaseFullPage`初始化一个`新的page`，调用`setHotPage`设置为当前操作页面, 然后调用`add方法`将`对象添加至page栈中`
	* 当`page不存在`时，调用`autoreleaseNoPage`创建一个`hotPage`,然后调用`add方法`将`对象添加至page栈中`。		
* 6.当执行`pop操作`时,会`传入一个值`，这个值就是`push操作的返回值`，即`POOL_BOUNDARY的内存地址token`,所以`pop内部`操作的实现就是`根据token找到哨兵对象所处的page`中，然后使用`objc_release `释放`token `之前的对象，并将`next指针到正确位置`。

# 子线程中的AutoreleasePool

# 未开启子线程RunLoop
在子线程中执行程序默认是不开启RunLoop的。
在子线程你创建了 Pool 的话，产生的 Autorelease 对象就会交给 pool 去管理。如果你没有创建 Pool ，但是产生了 Autorelease 对象，就会调用 autoreleaseNoPage 方法。在这个方法中，会自动帮你创建一个 hotpage（hotPage 可以理解为当前正在使用的 AutoreleasePoolPage，如果你还是不理解，可以先看看 Autoreleasepool 的源代码，再来看这个问题 ），并调用page->add(obj)将对象添加到 AutoreleasePoolPage 的栈中，也就是说你不进行手动的内存管理，也不会内存泄漏啦！

如果当前线程没有AutorelesepoolPage的话，代码执行顺序为autorelease -> autoreleaseFast -> autoreleaseNoPage。

在autoreleaseNoPage方法中，会创建一个hotPage，然后调用page->add(obj)。也就是说即使这个线程没有AutorelesepoolPage，使用了autorelease对象时也会new一个AutoreleasepoolPage出来管理autorelese对象，不用担心内存泄漏。

## 何时释放

```
__weak id obj;
[NSThread detachNewThreadSelector:@selector(createAndConfigObserverInSecondaryThread) toTarget:self withObject:nil];
```
> watchpoint set variable obj

```
- (void)createAndConfigObserverInSecondaryThread{
    __autoreleasing id test = [NSObject new];
    NSLog(@"obj = %@", test);
    obj = test;
    [[NSThread currentThread] setName:@"test runloop thread"];
    NSLog(@"thread ending");
}
```

通过这个调用栈可以看到释放的时机在`_pthread_exit`。然后执行到`AutorelepoolPage`的`tls_dealloc`方法。也就是说`thread`在退出时会释放自身资源，这个操作就包含了销毁`autoreleasepool`，在`tls_delloc`中，执行了`pop`操作。

## 总结
1.子线程在使用autorelease对象时，如果没有autoreleasepool会在autoreleaseNoPage中懒加载一个出来。

2.在runloop的run:beforeDate，以及一些source的callback中，有autoreleasepool的push和pop操作，总结就是系统在很多地方都差不多autorelease的管理操作。

3.就算插入没有pop也没关系，在线程exit的时候会释放资源，执行AutoreleasePoolPage::tls_dealloc，在这里面会清空autoreleasepool。