//
//  GCDLogController.m
//  QYInterview
//
//  Created by cyd on 2022/3/2.
//

#import "GCDLogController.h"

@interface GCDLogController ()

@end

@implementation GCDLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self log1];
    [self log2];
}
- (void)log1 {
    NSLog(@"串行队列，先进先出,同步之前有异步先执行异步，否则执行同步");
    dispatch_queue_t serialQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    dispatch_sync(serialQueue, ^{
        NSLog(@"4");
    });
    NSLog(@"5");
}
- (void)log2 {
    // 队列先进先出， performSelector:withObject:afterDelay 优先级低
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_after -> 1");
    });
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"dispatch_async -> 2");
//    });
//    [self performSelector:@selector(log2Sel3)];
    
    [self performSelector:@selector(log2Sel4) withObject:nil afterDelay:0];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"5");
//    });
    [self log2Sel6];
    
}
- (void)log2Sel3 {
    NSLog(@"3");
}
- (void)log2Sel4 {
    NSLog(@"4");
}
- (void)log2Sel6 {
    NSLog(@"6");
}
@end
