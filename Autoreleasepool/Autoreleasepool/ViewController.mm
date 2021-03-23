//
//  ViewController.m
//  Autoreleasepool
//
//  Created by cyd on 2021/3/11.
//

#import "ViewController.h"
struct QYTest {
    QYTest() {
        index = 10;
        NSLog(@"%d",index);
    }
    ~QYTest() {
        index = 20;
        NSLog(@"%d",index);
    }
    int index;
};
@interface AutoreleasePersion : NSObject
+ (instancetype)persion;
@end

@implementation AutoreleasePersion
+ (instancetype)persion {
    return [[self alloc] init];
}
- (void)dealloc {
    NSLog(@"被释放了");
}
@end
@interface ViewController ()
@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"开始");
    {
        QYTest test;
    }
    NSLog(@"结束");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self createThread];
//    for (int index = 0; index < 1000000; index++) {
//        AutoreleasePersion *string = [AutoreleasePersion persion];
//
//    }
}
- (void)createThread {
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    [_thread start];
}
__weak id weakObjc;
- (void)threadRun {
//    [self timeAction];
//    NSTimer *time = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
    __autoreleasing id test = [NSObject new];
    NSLog(@"%@",test);
    NSInvocation
    // watchpoint set variable weakObjc
    weakObjc = test;
    [[NSThread currentThread] setName:@"test runloop thread"];
    NSLog(@"thread ending");
}
- (void)timeAction {
    for (int index = 0; index < 100; index++) {
        AutoreleasePersion *string = [AutoreleasePersion persion];
        
    }
}
@end
