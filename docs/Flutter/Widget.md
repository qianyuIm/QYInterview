# Widget
* `Widget`实际上就是`Element`的配置数据，`Widget`树实际上是一个配置树，而真正的UI渲染树是由`Element`构成；不过，由于`Element`是通过`Widget`生成的，所以它们之间有对应关系，在大多数场景，我们可以宽泛地认为`Widget`树就是指UI控件树或UI渲染树。
* 一个`Widget`对象可以对应多个`Element`对象。这很好理解，根据同一份配置（`Widget`），可以创建多个实例（`Element`）。


## Stata 生命周期
* 	`initState` : 当`Widget`第一次插入到`Widget`树时会被调用，对于每一个`State`对象，`Flutter framework`只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。不能在该回调中调用`BuildContext.dependOnInheritedWidgetOfExactType`（该方法用于在`Widget`树上获取离当前`widget`最近的一个父级`InheritFromWidget`，关于`InheritedWidget`我们将在后面章节介绍），原因是在初始化完成后，`Widget`树中的`InheritFromWidget`也可能会发生变化，所以正确的做法应该在在`build()`方法或`didChangeDependencies()`中调用它。

*  `didChangeDependencies()`：当`State`对象的依赖发生变化时会被调用；例如：在之前`build() `中包含了一个`InheritedWidget`，然后在之后的`build() `中`InheritedWidget`发生了变化，那么此时`InheritedWidget`的子`widget`的`didChangeDependencies()`回调都会被调用。典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。

*  `build()`：此回调读者现在应该已经相当熟悉了，它主要是用于构建Widget子树的，会在如下场景被调用：
	1. 在调用`initState()`之后。
	2. 在调用`didUpdateWidget()`之后。
	3. 在调用`setState()`之后。
	4. 在调用`didChangeDependencies()`之后。
	5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。

* `reassemble()`：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。

* `didUpdateWidget()`：在widget重新构建时，Flutter framework会调用`Widget.canUpdate`来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回`true`则会调用此回调。正如之前所述，`Widget.canUpdate`会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时`didUpdateWidget()`就会被调用。

* `deactivate()`：当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter framework会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。如果移除后没有重新插入到树中则紧接着会调用`dispose()`方法。

* `dispose()`：当State对象从树中被永久移除时调用；通常在此回调中释放资源。

![Flutter_Stata](../images/Flutter_Stata.jpg)

## 为什么要将build方法放在State中，而不是放在StatefulWidget中？
现在，我们回答之前提出的问题，为什么build()方法放在State（而不是StatefulWidget）中 ？这主要是为了提高开发的灵活性。如果将build()方法在StatefulWidget中则会有两个问题：

* 状态访问不便。
* 继承StatefulWidget不便。
	

