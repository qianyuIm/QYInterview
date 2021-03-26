//
//  ViewController.m
//  GCD
//
//  Created by cyd on 2021/3/24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"https://juejin.cn/post/6937199229571956767#heading-93");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self oneCreateQueue];
}
#pragma mark - 创建串行队列
- (void)oneCreateQueue {
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.GCD.APP", DISPATCH_QUEUE_SERIAL);
    
}
- (void)once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return  YES;
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return  nil;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return  nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}
@end
