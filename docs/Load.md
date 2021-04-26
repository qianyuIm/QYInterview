# +load 与 +initialize

## + load
在类被引用进项目的时候就会执行load函数(在main函数开始执行之前)。与这个类是否被用到无关，每个load函数只会自动调用一次，由于load函数是系统加载的，因此不需要调用父类的load函数，否则父类的load函数会被多次执行。调用顺序如下:

1. 当父类和子类都实现load函数时，父类load执行顺序要优于子类
2. 当子类未实现load方法时，不会调用父类的load(排除系统调用，子类调用父类会执行两次父类load)
3. 类中的load方法执行顺序要优于类别(Category)
4. 当有多个类别(Category)都实现了load方法，这几个load方法都会执行，但是执行顺序不确定(其执行顺序与类别在Compile Sources中出现的顺序一致)
5. 当有多个类和对应的类别(Category)时，先执行类的load(执行顺序与其在Compile Sources中出现的顺序一致)，然后执行类别(Category)的load方法(执行顺序与其在Compile Sources中出现的顺序一致)

> 常用场景，交换两个方法的实现

## + initialize
initialize 在类或者其子类的第一个方法被调用前调用。即使类文件被引入项目，但是如果没有被使用, initialize不会被调用，由于是系统自动调用，也不需要调用[super initialize],否则父类的initialize会被多次执行

1. 父类的initialize方法比子类的先执行
2. 当子类未实现initialize方法时，会调用父类的initialize方法，子类实现initialize方法时，会覆盖(调用)父类的initialize方法,所以为了防止父类initialize中代码多次执行,我们应该这样写:

```swift
+(void)initialize
{
    if(self == [Person class]) {
        NSLog(@"%s",__FUNCTION__);
    }
}
```

3. 当有多个类别(Category)都实现了initialize方法，会覆盖类中的方法，只执行一个(会执行Compile Sources列表中最后一个Category的initialize方法)

> 常用场景:主要用来对一些不方便在编译期初始化的对象进行赋值