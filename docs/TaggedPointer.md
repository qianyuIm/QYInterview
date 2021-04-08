## TaggedPointer

* 从64bit开始，iOS引入了Tagged Pointer技术，用于优化NSNumber、NSDate、NSString等小对象存储
* 在没有使用Tagged Pointer之前，NSNumber等对象需要动态分配内存、维护引用计数等，NSNumber指针存储的是堆中NSNumber对象的地址值
* 使用Tagged Pointer之后，NSNumber指针里面存储的数据变成了：Tag + Data，也就是将数据直接存储在了指针中，Tagged Pointer指针的值不再是地址了，而是真正的值。所以，实际上它不再是一个对象了，它只是一个披着对象皮的普通变量而已。所以，它的内存并不存储在堆中，也不需要malloc和free。
* 在内存读取上有着3倍的效率，创建时比以前快106倍。不但减少了64位机器下程序的内存占用，还提高了运行效率。完美地解决了小内存对象在存储和访问效率上的问题。
* 这是一个特别的指针，不指向任何一个地址
* 当指针不够存储数据时，才会使用动态分配内存的方式来存储数据

示例代码: 

```
// 坏内存访问
dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    for (int index = 0; index < 100; index++) {
        dispatch_async(queue1, ^{
            self.name = [NSString stringWithFormat:@"123123123123123123123123123123123123"];
            NSLog(@"我来了1");
        });
    }
  // 正常
 dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    for (int index = 0; index < 100; index++) {
        dispatch_async(queue2, ^{
            self.name = [NSString stringWithFormat:@"abcd"];
            NSLog(@"我来了2");
        });
    }
```


