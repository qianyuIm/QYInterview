//
//  ViewController.m
//  RunLoop
//
//  Created by cyd on 2022/2/16.
//

#import "ViewController.h"
#import "DSThread.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL finish;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    _finish = true;
}
@end
