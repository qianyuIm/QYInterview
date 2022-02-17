//
//  ViewController.m
//  RunLoop
//
//  Created by cyd on 2022/2/16.
//

#import "ViewController.h"
#import "DSThread.h"

typedef void(^DSBlock)(NSString *name);
@interface ViewController ()
@property (nonatomic, assign) BOOL finish;
@property (nonatomic, copy) DSBlock block;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)runloop {
    _finish = NO;
    DSThread *thread = [[DSThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    }];
    [thread start];
}
- (void)timerMethod {
    static int num = 0;
    NSLog(@"定时器任务 - %d",num++);
    if (_finish) {
//        [NSThread exit];
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    _finish = true;
    [self test];
}
// 经典面试题
- (void)test {
    [self startAsync];
//    sleep(10);
    
    [self setBlock:^(NSString *name) {
        NSLog(@"%@",name);
    }];
    NSLog(@"睡眠结束");
}

- (void)startAsync {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"我是异步执行%@",[NSThread currentThread]);
        // 但是先判断的话，因为是异步线程中，直接判断，block为nil，所以不会执行
        // if (self.block) 内部的
//        if (self.block) {
        // 这个时候会返回到主线程，但是主线程在休眠，等待主线程休眠结束，且是async
        // 所以等待 setBlock 之后再执行 block
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"调用回调");
                if (self.block) self.block(@"异步返回");
            });
//        }
        
    });
}
@end
