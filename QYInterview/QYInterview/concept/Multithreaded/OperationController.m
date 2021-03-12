//
//  OperationController.m
//  QYInterview
//
//  Created by cyd on 2021/3/11.
//

#import "OperationController.h"

@interface OperationController ()

@end

@implementation OperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *conclusion = @"总结: Operation直接调用start方法，不与OperationQueue混合使用的时候是同步调用,区别在于BlockOperation 使用 addExecutionBlock 添加的任务会开启子线程并发执行,如果 通过addExecutionBlock添加的任务过多的话 BlockOperation 初始化方法blockOperationWithBlock：中添加的任务也可能在子线程中执行";
    NSLog(@"%@",conclusion);
}
#pragma mark - invocation 同步执行方法
- (IBAction)invocationOperationSyncAction:(id)sender {
    NSLog(@"开始");
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sync) object:nil];
    [operation start];
    NSLog(@"结束");
}
- (void)sync {
    [NSThread sleepForTimeInterval:1];
    NSLog(@"任务中 %@",[NSThread currentThread]);
}
#pragma mark - block 同步执行方法
- (IBAction)blockOperationSyncAction:(id)sender {
    NSLog(@"开始");
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务1中 %@",[NSThread currentThread]);
    }];
    for (int index = 2; index < 800; index++) {
        [operation addExecutionBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"任务%d中 %@",index,[NSThread currentThread]);
        }];
    }
    [operation start];
    NSLog(@"结束");
}
#pragma mark - invocation 异步执行方法
- (IBAction)invocationOperationAsyncAction:(id)sender {
    NSLog(@"任务开始");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    for (int index = 0; index < 100; index++) {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(async:) object:[NSNumber numberWithInt:index]];
        [queue addOperation:operation];
    }
    NSLog(@"任务结束");
}
- (void)async:(NSNumber*)number {
    [NSThread sleepForTimeInterval:1];
    NSLog(@"任务%@中 %@",number,[NSThread currentThread]);
}
#pragma mark - block 异步执行方法
- (IBAction)blockOperationAsyncAction:(id)sender {
    NSLog(@"任务开始");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务1中 %@",[NSThread currentThread]);
    }];
    for (int index = 2; index < 800; index++) {
        [operation addExecutionBlock:^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"任务%d中 %@",index,[NSThread currentThread]);
        }];
    }
    [queue addOperation:operation];
    NSLog(@"任务结束");
}
#pragma mark - 普通依赖
- (IBAction)dependencyAction:(id)sender {
    NSLog(@"任务开始");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dependency:) object:@1];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dependency:) object:@2];
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dependency:) object:@3];
    NSInvocationOperation *operation4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dependency:) object:@4];
    [operation1 addDependency:operation2];
    [operation2 addDependency:operation3];
    [operation3 addDependency:operation4];

    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    NSLog(@"任务结束");
}
- (void)dependency:(NSNumber*)number {
    [NSThread sleepForTimeInterval:1];
    NSLog(@"任务%@中 %@",number,[NSThread currentThread]);
}
#pragma mark - 网络请求依赖 单纯设置依赖达不到效果，因为网络请求是异步耗时操作
- (IBAction)loadDependencyAction:(id)sender {
    NSLog(@"任务开始");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 1;
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadDependency:) object:@1];
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadDependency:) object:@2];
    NSInvocationOperation *operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadDependency:) object:@3];
    NSInvocationOperation *operation4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadDependency:) object:@4];
    [operation4 addDependency:operation3];
    [operation3 addDependency:operation2];
    [operation2 addDependency:operation1];
    [operation1 class];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:operation4];
    NSLog(@"任务结束");
}
- (void)loadDependency:(NSNumber*)number {
    NSLog(@"任务 %@开始",number);
    [self loadDataPar:number callBack:^(NSNumber *string) {
        NSLog(@"任务%@ 结束",string);
    }];
}
-(void)loadDataPar:(NSNumber*)num
          callBack:(void(^)(NSNumber *string))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        // 模拟耗时操作
        // 3 ~ 5 之间随机数
        int timeInterval = arc4random() % (5 - 3 + 1) + 3;;
        [NSThread sleepForTimeInterval:timeInterval];
        dispatch_async(mainQueue, ^{
            block(num);
        });
    });
}

@end
