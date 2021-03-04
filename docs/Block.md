# Block
* **[Block的类型](#block的类型)**

block匿名函数,也是一个OC对象，因为有isa指针

### Block的类型
* _NSConcreteGlobalBlock: 
	
> 没有用到外界变量或只用到全局变量、静态变量的block为_NSConcreteGlobalBlock，生命周期从创建到应用程序结束。

* _NSConcreteStackBlock

> 只用到外部局部变量、成员属性变量，且没有强指针引用的block都是StackBlock。
StackBlock的生命周期由系统控制的，一旦返回之后，就被系统销毁了。

* _NSConcreteMallocBlock

> 有强指针引用或copy修饰的成员属性引用的block会被复制一份到堆中成为MallocBlock，没有强指针引用即销毁，生命周期由程序员控制

在ARC环境下系统会默认把 StackBlock copy 到堆上 变为MallocBlock