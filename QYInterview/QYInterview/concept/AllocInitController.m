//
//  InitController.m
//  QYInterview
//
//  Created by cyd on 2021/2/23.
//

#import "AllocInitController.h"

@interface Reference : NSObject
@property (nonatomic, strong) NSString *name;
@end
@implementation Reference
- (void)dealloc {
    NSLog(@"移除了");
}
@end

@interface AllocInitController ()

@end

@implementation AllocInitController
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSLog(@"页面将要出现");
//}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"页面已经出现");
//}
/**
 *  结论:  一个对象在初始化后默认是强引用的
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testAllocInit];
}
///验证初始化
// alloc的主要作用就是开辟内存空间。 alloc -> _objc_rootAlloc -> callAlloc -> _objc_rootAllocWithZone
// init 返回对象本身，这里的init是一个构造方法 ，是通过工厂设计（工厂方法模式）,主要是用于给用户提供构造方法入口。init -> _objc_rootInit(obj) -> obj
// 一般在开发中，初始化除了init，还可以使用new，两者本质上并没有什么区别，以下是objc中new的源码实现，通过源码可以得知，new函数中直接调用了callAlloc函数（即alloc中分析的函数），且调用了init函数，所以可以得出new其实就等价于 [alloc init]的结论。
// 但是一般开发中并不建议使用new，主要是因为有时会重写init方法做一些自定义的操作，用new初始化可能会无法走到自定义的部分。


- (void)testAllocInit {
    Reference *refe = [Reference alloc];
    refe.name = @"小红";
    NSLog(@"refe = %@",refe);
    Reference *refe1 = [refe init];
    NSLog(@"refe = %@",refe);
    NSLog(@"refe1 = %@",refe1);
    
    
}
///验证一个对象初始化后是强引用还是弱引用
- (void)testStrongOrWeak {
    Reference *refe = [[Reference alloc] init];
    refe.name = @"小红";
    // 默认 为__strong 修饰
    Reference *refe1 = refe;
    // 强引用
//    __strong Reference *refe1 = refe;
    // 弱引用
//    __weak Reference *refe1 = refe;
    NSLog(@"%@,%@",refe,refe1);
    refe = nil;
    NSLog(@"%@,%@",refe,refe1);
}
@end
