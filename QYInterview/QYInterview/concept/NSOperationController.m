//
//  NSOperationController.m
//  QYInterview
//
//  Created by cyd on 2021/2/26.
//

#import "NSOperationController.h"
#import <objc/runtime.h>
@interface QYOperation : NSInvocation
@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation QYOperation
@synthesize executing = _executing;
@synthesize finished = _finished;
//+ (void)load {
//    //获取系统方法结构体
//       Method system = class_getClassMethod([self class], @selector(main));
//       //获取自己方法结构体
//       Method own = class_getClassMethod([self class], @selector(qy_main));
//       // 交换方法 系统的 URLWithString 和自己的 SJUrlWithStr
//       //交换自己方法和系统方法
//       method_exchangeImplementations(system, own);
//       //以后再使用 URLWithString 的时候 其实是在调用SJUrlWithStr
//}
- (instancetype)init {
    if (self = [super init]) {
        _executing = NO;
        _finished = NO;
    }
    return self;
}
- (void)start {
    NSLog(@"123");
}
- (void)main {
    NSLog(@"456");
}
//- (void)setFinished:(BOOL)finished {
//    [self willChangeValueForKey:@"isFinished"];
//    _finished = finished;
//    [self didChangeValueForKey:@"isFinished"];
//}
//
//- (void)setExecuting:(BOOL)executing {
//    [self willChangeValueForKey:@"isExecuting"];
//    _executing = executing;
//    [self didChangeValueForKey:@"isExecuting"];
//}
//- (BOOL)isConcurrent {
//    return YES;
//}

@end
@interface NSOperationController ()

@end

@implementation NSOperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    QYOperation *op = [[QYOperation alloc] init];
//    [op start];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:op];
    
}
- (void)doSome {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
