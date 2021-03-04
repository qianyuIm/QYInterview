//
//  ChildThreadLoopController.m
//  QYInterview
//
//  Created by cyd on 2021/2/25.
//

#import "ChildThreadLoopController.h"

@interface ChildThread : NSThread

@end

@implementation ChildThread
- (void)dealloc {
    NSLog(@"我释放了");
}
@end

@interface ChildThreadLoopController ()
@property (nonatomic, strong) ChildThread *thread;
//@property (nonatomic, strong) NSRunLoop *runLoop;
//@property (nonatomic, strong) NSMachPort *port;
@property (nonatomic, assign) BOOL isAborted;

@end

@implementation ChildThreadLoopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;
    ChildThread *thread = [[ChildThread alloc] initWithBlock:^{
        [weakSelf threadAction];
    }];
    _thread = thread;
    [_thread start];
    [self registerObserver];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self performSelector:@selector(testLoopStop1) onThread:_thread withObject:nil waitUntilDone:false];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    _port = nil;
    [self testgcd];
}
- (void)registerObserver {
    
    // 创建观察者
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            NSLog(@"监听到RunLoop发生改变---%zd",activity);
        });

        // 添加观察者到当前RunLoop中
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);

        // 释放observer，最后添加完需要释放掉
        CFRelease(observer);
}
- (void)testgcd {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"返回主线程");
    });
}
- (void)test1 {
    ChildThread *thread = [[ChildThread alloc] initWithBlock:^{
        NSLog(@"123");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
            NSLog(@"timer");
            CFRunLoopStop(CFRunLoopGetCurrent());
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        NSDate *date = [NSDate dateWithTimeInterval:10 sinceDate:[NSDate date]];
//        NSLog(@"%@",date);
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    }];
    [thread start];
}
- (void)threadAction {
    [self testLoopRun1];
}
- (void)testLoopRun1 {
//    _runLoop = [NSRunLoop currentRunLoop];
    NSLog(@"%@",[NSThread currentThread]);
//    _port = [NSMachPort port];
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"runLoop 退出");
}
- (void)testLoopStop1 {
    CFRunLoopStop(CFRunLoopGetCurrent());
    _thread = nil;
}
- (void)dealloc {
    [self performSelector:@selector(testLoopStop1) onThread:_thread withObject:nil waitUntilDone:false];
}
@end
