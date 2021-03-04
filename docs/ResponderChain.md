# 响应者链

### 事件的发布和传递
1. 在iOS程序中发生触摸事件后，系统会将事件加入到UIApplication管理的一个任务队列中
2. UIApplication将处于任务队列最前端的事件向下发布。即UIWindow
3. UIWindow将事件向下发布。即UIView
4. UIView首先看自己能否处理事件，触摸点是否在自己身上。如果能，那么继续寻找子试图
5. 倒序遍历子控件，重复以上两步
6. 如果没有找到，那么自己就是事件的处理者
7. 如果自己不能处理，那么久不做任何处理，废弃事件

其中UIView不能处理事件的情况主要以下三种:
> alpha < 0.01

> userInteractionEnabled = NO

> hidden = YES

这个从父控件到子控件寻找处理时间最合适View的过程就是事件的传递。如果父视图不接受事件处理(上面三种情况),则子试图也不能接收事件。事件只要触摸了就会产生，关键在于是否有最合适的view来处理和接收事件，如果遍历到最后都没有最合适的view来接收事件，则该事件被废弃

```swift
// 因为所有的视图类都是继承BaseView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   // 1.判断当前控件能否接收事件
   if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
   // 2. 判断点在不在当前控件
   if ([self pointInside:point withEvent:event] == NO) return nil;
   // 3.从后往前遍历自己的子控件
   NSInteger count = self.subviews.count;
   for (NSInteger i = count - 1; i >= 0; i--) {
       UIView *childView = self.subviews[I];
       // 把当前控件上的坐标系转换成子控件上的坐标系
    CGPoint childP = [self convertPoint:point toView:childView];
      UIView *fitView = [childView hitTest:childP withEvent:event];
       if (fitView) { // 寻找到最合适的view
           return fitView;
       }
   }
   // 循环结束,表示没有比自己更合适的view
   return self;
   
}
``` 

### 响应者链
响应链从最合适的View开始传递。处理事件传递给下一个响应者，响应者链的传递方向是事件传递的反方向，如果所有的响应者都不处理事件，则事件被丢弃。