//
//  CycleController.m
//  Block
//
//  Created by cyd on 2021/3/25.
//

#import "CycleController.h"

typedef void(^QYBlock)(void);
typedef void(^QYBlockP)(CycleController *);

@interface QYProxy: NSProxy
@property (nonatomic, weak, readonly) NSObject *target;
- (id)transformTarget:(NSObject *)target;
+ (instancetype)proxyWithTransformTarget:(id)target;
@end


@implementation QYProxy
- (id)transformTarget:(NSObject *)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTransformTarget:(id)target{
    return [[self alloc] transformTarget:target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature;
    if (self.target) {
        signature = [self.target methodSignatureForSelector:sel];
    } else {
        signature = [super methodSignatureForSelector:sel];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

@end

@interface CycleController ()
@property (nonatomic, copy) QYBlock block;
@property (nonatomic, copy) QYBlockP blockP;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) QYProxy *proxy;

@end

@implementation CycleController
- (void)dealloc {
    // 设置为 self.proxy 在这里释放旧可以了
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"移除了");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 设置为 self 需要在这里释放
//    [self.timer invalidate];
//    self.timer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)test {
    
}
// 属于自动释放
- (IBAction)weakCycle:(id)sender {
    self.name = @"小红";
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        QYNSLog(@"%@",weakSelf.name);
    };
    // 调用或者不调用 都可以解决循环引用的问题
    self.block();
}
// 属于手动释放
- (IBAction)blockCycle:(id)sender {
    self.name = @"小红";
    __block CycleController *vc = self;
    self.block = ^{
        QYNSLog(@"%@",vc.name);
        vc = nil;
    };
    // 必须调用
    self.block();
}
- (IBAction)parameterSelfCycle:(id)sender {
    self.name = @"小红";
    self.blockP = ^(CycleController *vc) {
        QYNSLog(@"%@",vc.name);
    };
    self.blockP(self);
}
- (IBAction)proxyCycle:(id)sender {
    self.proxy = [QYProxy proxyWithTransformTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHome) userInfo:nil repeats:YES];
}
- (void)fireHome{
    QYNSLog(@"hello word ");
}

@end
