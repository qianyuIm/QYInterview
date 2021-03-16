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