//
//  ViewController.m
//  内存平移
//
//  Created by cyd on 2022/2/14.
//

#import "ViewController.h"

@interface DSPersion: NSObject
@property (nonatomic, copy) NSString *ds_name;
@property (nonatomic, assign) int ds_body;
- (void)saySomething;

@end

@implementation DSPersion
- (void)saySomething {
    // test1
//    NSLog(@"打印当前内容为%s",__func__);

    NSLog(@"打印当前内容为%s - %@",__func__,self.ds_body);
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Class cls = [DSPersion class];
    void *obj = &cls;
    DSPersion *persion = [DSPersion alloc];
    [(__bridge  id)obj saySomething];
    
    
    [persion saySomething];
    
}
/// 所以，person是指向DSPersion类的结构，
/// obj也是指向DSPersion类的结构，
/// 然后都是在DSPersion类中的methodList中查找方法.
- (void)test1 {
    // 类的内存结构为 isa  superclass cache bits
    // 实例对象的内存结构为 isa 属性
    
    // cls 指向 DSPersion的首地址
    Class cls = [DSPersion class];
    // obj 指向 DSPersion的首地址
    void *obj = &cls;
    // 我们可以通过TCJPerson的内存平移找到cache，在cache中查找方法
    [(__bridge  id)obj saySomething];
    
    // persion 的 isa指向类DSPersion
    // 即 persion 的首地址 指向 DSPersion的首地址
    DSPersion *persion = [DSPersion alloc];
    // 本质是对象发送消息
    // 我们可以通过TCJPerson的内存平移找到cache，在cache中查找方法
    [persion saySomething];
}

@end
