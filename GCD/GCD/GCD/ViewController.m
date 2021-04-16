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
    [self testOrder];
}
- (void)testOrder {
//    dispatch_queue_t queue = dispatch_queue_create("ww", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_queue_create("ww", DISPATCH_QUEUE_SERIAL);

    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    sleep(2);
    NSLog(@"5");
}
// MARK:--测试栅栏函数
- (void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create("com.222.22", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self asyncTask:@"1" callBack:^(NSString *task) {
            NSLog(@"%@", task);
        }];
    });
    dispatch_async(queue, ^{
        [self asyncTask:@"2" callBack:^(NSString *task) {
            NSLog(@"%@", task);
        }];
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"我是一个栅栏");
    });
    dispatch_async(queue, ^{
        [self asyncTask:@"3" callBack:^(NSString *task) {
            NSLog(@"%@", task);
        }];
    });
    dispatch_async(queue, ^{
        [self asyncTask:@"4" callBack:^(NSString *task) {
            NSLog(@"%@", task);
        }];
    });
    
}
- (void)testBarrier1 {
//    dispatch_queue_t queue = dispatch_queue_create("com.222.22", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 2000; i++) {
        dispatch_async(queue, ^{
            dispatch_barrier_async(queue, ^{
                [array addObject:@1];
                NSLog(@"add");
            });
        });
    }
    NSLog(@"count = %lu",(unsigned long)array.count);
}
// 异步任务
- (void)asyncTask:(NSString*)task
         callBack:(void(^)(NSString *task))block{
    // 耗时任务
//    sleep(2);
    block(task);
//    NSLog(@"%@",[NSThread currentThread]);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(queue, ^{
//        dispatch_async(mainQueue, ^{
//            block(task);
//        });
//    });
}



@end
