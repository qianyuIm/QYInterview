# Swift调用KVO

需要该类集成NSObject，并属性添加 @objc dynamic

```
class MapPersion: NSObject {
     @objc dynamic var name: String = ""
}
```

swift 中的函数可以静态调用，静态调用会更快。当函数是静态调用的时候，就不能从字符串查找到对应的方法地址了。这样 Swift 跟 Objective-C 交互时，Objective-C 动态查找方法地址，就有可能找不到 Swift 中定义的方法。这样就需要在 Swift 中添加一个提示关键字 @objc dynamic，告诉编译器这个方法是可能被动态调用的，需要将其添加到查找表中。这个就是关键字 dynamic 的作用。