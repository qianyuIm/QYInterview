# Block
* **[Block的类型](#block的类型)**


> xcrun -sdk iphonesimulator clang -arch x86_64 -rewrite-objc xxx.m(xxx.c)

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

### 打破循环引用
1. 打破self对block的强引用，可以将`block`属性使用`weak`修饰，但是这样会导致`block`还没创建完就被释放，所以这种方式不可行.
2. 打破block对self的强引用：

	1. `weak-strong-dance`
	2. `__block`(`block`内对象置空，且调用`block`)
	3. 将对象`self`作为`block`的参数
	4. 通过`NSProxy`的子类代替`self`

### Block引用外部变量

外界变量通过`__block`生成`__Block_byref_a_0`结构体

`结构体`用来`保存原始变量的指针和值`

将变量生成的`结构体对象的指针地址`传递给`block`，然后在`block`内部就可以对外界变量进行操作了。

`__block`和非`__block`修饰局部变量产生两种不同的拷贝：

1. 非`__block`修饰：`值拷贝` -` 深拷贝`，只是拷贝数值，且拷贝的值不可更改，指向不同的内存空间。
2. `__block修饰`：`指针拷贝` - `浅拷贝`，`生成的对象`指向`同一片内存空间`。

