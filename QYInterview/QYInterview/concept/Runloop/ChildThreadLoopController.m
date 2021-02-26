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
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self performSelector:@selector(testLoopStop1) onThread:_thread withObject:nil waitUntilDone:false];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    _port = nil;
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
