# Runtime
 -[```objc``` 对象的```isa``` 的指针指向什么?有什么作用?](#```objc``` 对象的```isa``` 的指针指向什么?有什么作用?)
 
-[分类为什么不能添加实例变量的原因](#分类为什么不能添加实例变量的原因)



## ```objc``` 对象的```isa``` 的指针指向什么?有什么作用?

	指向他的类对象，从而可以找到类对象上的方法。
	
![mete_class](images/mete_class.png)

OC中任何类的定义都是对象，任何对象都有```isa```指针。```isa```是一个Class类型的指针。
### isa指针
实例的isa指针，指向类。

类的isa指针，指向元类。

元类的isa指针，指向根元类。

父元类的isa指针，也指向根元类！！！

根元类的isa指针，指向它自己！！！
### superClass
类的superClass指向父类。

父类的superClass指向根类。

根类的superClass指向nil。

元类的superClass指向父元类。

父元类的superClass指向根元类。

根元类的superClass指向根类！！！

##分类为什么不能添加实例变量的原因？
分类 Category 实际是一个category_t结构体,包含了 实例方法列表，类方法列表， 协议列表和属性列表但是没有实例变量列表，Category在运行期，对象的内存布局已经确定，如果添加实例变量就会破坏类的内部结构

```
struct category_t {
        //类的名字
        const char *name;
        //类
        classref_t cls;
        //category中所有给类添加的实例方法的列表
        struct method_list_t *instanceMethods;
        //category中所有添加的类方法的列表
        struct method_list_t *classMethods;
        //category实现的所有协议的列表
        struct protocol_list_t *protocols;
        //category中添加的所有属性
        struct property_list_t *instanceProperties;

        method_list_t *methodsForMeta(bool isMeta) {
            if (isMeta) return classMethods;
            else return instanceMethods;
        }
        property_list_t *propertiesForMeta(bool isMeta) {
            if (isMeta) return nil; // classProperties;
            else return instanceProperties;
        }
    };
```

### Category 和 Extension 的区别
* ```Extension```在编译器决议，它是类的一部分，在编译器和头文件里的```@interface ```以及实现文件里的 ```@implement```一起形成一个完整的类，它伴随这类的产生而产生，亦随之一起消亡。```Extension```一般用来隐藏类的私有信息，你必须有一个类才能为之添加```Extension```，比如你不能为系统的```NSString```添加 ```Extension```
* ```Category```则完全不一样，它是运行期决议的。
* ```Extension```可以添加成员变量，而```Category```不可以。
* 总之，就```Category``` 和 ```Extension```区别来看，```Extension```可以添加成员变量，而```Category```不可以，因为```Category```在运行期，对象的内存布局已经确定，如果添加实例变量就会破坏类的内存布局。

### super 和 self
看下面代码 打印什么?

```
@interface HookPersion : HookBase 

@end
@implementation HookPersion
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));

    }
    return self;
}
@end
```

> 结果都是打印 HookPersion

原因是: 

**self** 是类的隐藏参数，指向当前调用方法的这个类的实例；

**super** 本质是一个编译器的标识符，和**self**指向同一个消息接受者，不同点在于: **super**会告诉编译器，当调用方法时，去调用父类的方法，而不是本类的方法；

当使用self调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找，而当使用super时，则从父类的方法列表中开始查找，然后调用父类的这个方法。

不管是调用```[self class]``` 还是```[super class]```接收消息的对象都是当前的 HookPersion *xxx对象

当调用 ```[super class]```时，**runtime**会调用```objc_msgSendSuper```方法，而不是```objc_msgSend```

```
[self class] 转化为: id objc_msgSend(id self, SEL op, ...)


[super class] 转化为: id objc_msgSendSuper(struct objc_super *super, SEL op, ...)
第一个参数为： objc_super这样一个结构体，定义如下：
struct objc_super {
      __unsafe_unretained id receiver;
      __unsafe_unretained Class super_class;
};
结构体有两个成员，第一个成员是 receiver, 类似于上面的 objc_msgSend函数第一个参数self 。第二个成员是记录当前类的父类是什么。
当调用[super class]时，会转化为 objc_msgSendSuper 
第一步先构造 objc_super 结构体，结构体第一个成员就是 self 。
第二个成员是 (id)class_getSuperclass(objc_getClass(“Son”)) , 实际该函数输出结果为 HookBase。
第二步是去 HookBase这个类里去找 - (Class)class，没有，然后去NSObject类去找，找到了。最后内部是使用 objc_msgSend(objc_super->receiver, @selector(class))去调用，此时已经和[self class]调用相同了

```
> 

### objc中的类方法和实例方法有什么本质区别和联系？
类方法(+ 方法):

	1. 	类方法是属于类对象的
	2. 类方法只能通过类对象调用
	3. 类方法中的self是类对象
	4. 类方法可以调用其他的类方法
	5. 类方法中不能访问成员变量
	6. 类方法中不能“直接”调用对象方法

实例方法(- 方法):

	1. 实例方法是属于实例对象的
	2. 实例方法只能通过实例对象调用
	3. 实例方法中的self是实例对象
	4. 实例方法中可以访问成员变量
	5. 实例方法中直接调用实例方法
	6. 实例方法中也可以调用类方法(通过类名)

