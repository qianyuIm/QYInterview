//
//  ChildFatherNSObjectController.m
//  QYInterview
//
//  Created by cyd on 2022/2/11.
//

#import "ChildFatherNSObjectController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (ChildFather)
@property (nonatomic, copy) NSString *name;
- (void)dsInstanceMethod;
+ (NSArray*)printMethods;
+ (void)printClassChain:(Class)aClass;
@end

@implementation NSObject (ChildFather)
- (void)dsInstanceMethod {
    NSLog(@"%p, dsInstanceMethod",self);
}
+ (NSArray*)printMethods {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int count = 0;
    Method *list = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *name = NSStringFromSelector(method_getName(list[i]));
        NSString *type = [NSString stringWithUTF8String:method_getTypeEncoding(list[i])];
        IMP imp = method_getImplementation(list[i]);
        [array addObject: [NSString stringWithFormat:@"name: %@,type encode: %@ IMP: %p",name, type, imp]];
    }
    free(list);
    return  array;
    
}
+ (void)printClassChain:(Class)aClass {
    NSLog(@"Class: %@ Address: %p",aClass,aClass);
    Class getClass = object_getClass(aClass);
    if (getClass != aClass) {
        [self printClassChain:getClass];
    } else {
        aClass = class_getSuperclass(aClass);
        NSLog(@"Class: %@ Address: %p",aClass,aClass);
    }
}


@end
@interface FatherPersion : NSObject
- (void)dsInstanceMethod;

@end
@implementation FatherPersion
- (void)dsInstanceMethod {
    NSLog(@"%p, dsInstanceMethod",self);
}



@end

@interface ChildFatherPersion : FatherPersion
+ (void)dsInstanceMethod;
@end

@implementation ChildFatherPersion

@end

@interface ChildFatherNSObjectController ()

@end

@implementation ChildFatherNSObjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ChildFatherPersion *persion = [[ChildFatherPersion alloc] init];
//    persion.name = @"123";
    [ChildFatherPersion dsInstanceMethod];
    [NSObject printClassChain:[ChildFatherPersion class]];
    // 类方法保存在元类中.根元类的父类的superclass 指向的是nsobject
    // sel方法名传递的时候是没有传递+/- . 通过objc_msgSend 调用的方法接受者 和sel方法.
    /**
     当我们调用 [ChildFatherPersion dsInstanceMethod]时，底层会有如下调用。先获取ChildFatherPersion类的meta class，找不到，继续往meta class的父类查找，最终找到根类就是 NSObject类，而 NSObject 类中是有同名方法的，所以可以调用到 NSObject的同名方法。

     作者：ijinfeng
     链接：https://juejin.cn/post/7007359273692823566
     来源：稀土掘金
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
