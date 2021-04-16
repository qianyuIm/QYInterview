## Alloc 和 init 都做了什么
## alloc

`alloc`  -> `_objc_rootAlloc` -> `callAlloc` -> `_objc_rootAllocWithZone` -> `_class_createInstanceFromZone `

alloc做了三件事情:

1. `cls->instanceSize(extraBytes);`计算需要开辟的内存空间大小，最小为16
2. `calloc `根据size申请内存，返回该内存地址的指针
3. `obj->initInstanceIsa`将cls类与`isa`关联


`init`  -> `_objc_rootInit ` 返回当前对象

```
id
_objc_rootInit(id obj)
{
    // In practice, it will be hard to rely on this function.
    // Many classes do not properly chain -init calls.
    return obj;
}

```

## 为什么要16字节对齐
* 提高性能，加快存储速度: 通常内存是由一个个字节组成，`cpu`在存储数据时，是以`固定字节块`为单位进行存取的，这是一个`空间换时间`的优化方式，这样不用考虑字节未对齐的数据，极大节省了计算资源，提升了存取速度。
* 更安全，由于在一个对象中，第一个属性`isa`占`8`字节，当然一个对象可能有其他属性，当无其它属性时，会预留`8字节`，即`16字节`对齐，因为苹果现在采用的是`16字节对齐(早期8字节 objc4-756.2及以前版本)`，如果不预留，就相当于这个对象的`isa`和其他对象的`isa`紧挨着，在`cpu`存取时以`16字节`为单位去访问，会访问到相邻对象，容易造成访问混乱，那么16字节对齐后，可以加快 cpu的读取速度，同时使访问更安全，不会产生访问混乱的情况。