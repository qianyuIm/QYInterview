# 多线程
## 1.NSThread
## 2.GCD
## 3. NSOperation
1. NSOperation 自定义	

* 重写的方法

```swift
// 对于并发的Operation需要重写改方法 SDWebImage
- (void)start;

// 非并发的Operation需要重写该方法 Toaster 吐司，注意不需要使用@autoreleasepool
- (void)main;
```
