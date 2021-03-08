//
//  GCDController.m
//  QYInterview
//
//  Created by cyd on 2021/2/23.
//

#import "GCDController.h"
/* 结论:
 * 串行队列异步任务: 因为是串行队列，队列中的所有任务按添加顺序一个一个执行，因为是异步，会创建新的线程
 * 并发队列异步任务: 并发队列下的异步函数会开启N条子线程，且执行任务的顺序我们无法控制，至于哪条线程执行任务由队列决定，哪个任务完成由CPU决定
 * 串行队列同步任务: 不会开辟新线程，所以所有的任务都会在主线程下依次执行
 * 并发队列同步任务： 不会开辟新线程，所以所有的任务都会在主线程下依次执行
 */
/** GCD 处理线程之间的依赖关系可以使用1
 * 1. dispatch_group_t
 * 2. 使用信号量
 *
 */
@interface GCDController ()

@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self test];
}
- (void)test {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //任务1
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"run task 1");
            sleep(1);
            dispatch_semaphore_signal(semaphore);
            NSLog(@"complete task 1");
        });
        //任务2
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"run task 2");
            sleep(1);
            dispatch_semaphore_signal(semaphore);
            NSLog(@"complete task 2");
        });
        //任务3
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"run task 3");
            sleep(1);
            NSLog(@"complete task 3");
            dispatch_semaphore_signal(semaphore);
        });
}
// 串行队列同步任务
- (void)serialQueueSyncTask {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"线程 = %@ -- %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"我是主线程 %@",[NSThread currentThread]);
}
// 串行队列异步任务
- (void)serialQueueAsyncTask {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"线程 = %@ -- %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"我是主线程 %@",[NSThread currentThread]);
}
// 并发队列同步任务
- (void)concurrentQueueSyncTask {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"线程 = %@ -- %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"我是主线程 %@",[NSThread currentThread]);
}
// 并发队列异步任务
- (void)concurrentQueueAsyncTask {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"线程 = %@ -- %d",[NSThread currentThread],i);
        });
    }
    NSLog(@"我是主线程 %@",[NSThread currentThread]);
}
- (void)testGroup {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务2");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务3");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务4");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务完成");
    });
    for (int i = 0; i < 10; i++) {
        NSLog(@"我是主线程- %@",[NSThread currentThread]);
    }
}
- (void)testGroup1 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self loadDataPar:@"1" callBack:^(NSString *string) {
        NSLog(@"%@", string);
        dispatch_group_leave(group);
    }];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    [self loadDataPar:@"2" callBack:^(NSString *string) {
        NSLog(@"%@", string);
        dispatch_group_leave(group);
    }];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(group);
    [self loadDataPar:@"3" callBack:^(NSString *string) {
        NSLog(@"%@", string);
        dispatch_group_leave(group);
    }];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务完成");
    });
}
///  异步任务变为同步任务
- (void)testAsyncToSync {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self loadDataPar:@"1" callBack:^(NSString *string) {
            NSLog(@"%@", string);
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        [self loadDataPar:@"2" callBack:^(NSString *string) {
            NSLog(@"%@", string);
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        [self loadDataPar:@"3" callBack:^(NSString *string) {
            NSLog(@"%@", string);
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"全部搞完了 %@",[NSThread currentThread]);

        });
    });
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            for (int i = 0 ; i < 5; i++) {
//                NSLog(@"开始%d",i);
//                // 模拟请求 ↓
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////                    sleep(3);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSLog(@"任务%d完成",i);
//                        dispatch_semaphore_signal(sema);
//                    });
//                });
//                // 模拟请求 上
//               dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            }
//           NSLog(@"全部搞完了");
//        });
}
- (void)loadDataPar:(NSString *)num callBack:(void(^)(NSString *string))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        dispatch_async(mainQueue, ^{
            block(num);
        });
    });
}

// 说明dispatch_barrier_async的顺序执行还是依赖queue的类型啊，
// 必需要queue的类型为dispatch_queue_create创建的，
// 而且attr参数值必需是DISPATCH_QUEUE_CONCURRENT类型，
// 前面两个非dispatch_barrier_async的类型的执行是依赖其本身的执行时间的，
// 如果attr如果是DISPATCH_QUEUE_SERIAL时，那就完全是符合Serial queue的FIFO特征了。
- (void)testBarrier {
//    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"3");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier");
    });
    dispatch_async(queue, ^{
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"5");
    });
}
// 1 5 2 3 4
- (void)test1 {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}
// 死锁
- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}
// 这个主要是资源抢夺问题.打印结果很大程度上和计算机性能有关
// 变量a使用__block修饰,使其能在block内部访问并修改!
// 然后我们使用一个while()循环,在内部,我们创建一个异步任务,并将其放在全局队列(并发队列)中执行!
// 该任务会开启新的线程去执行,由于是异步所以不会等待这个异步任务执行完毕,而是又回到while循环中执行
// 新的任务.也就是说,在我们一次循环结束重新进入循环是,我们下一次的任务所捕获到的变量a还可能是0!
// 依次循环,也就是说,在a=0时,任务回来之前会添加不止一个任务到队列.
// 那么,当任务执行完后,a的值会被++,此时所有捕获到a的任务中的a都会变为++后的值,当再有任务执行完成后a会被重新赋值.
// 所以在a<10的循环里,a会被++的次数远大于10,所以a的值是从1递增的值,具体到多大,就要看系统对线程调度的能力了
// 循环外部的打印:当任务返回的a<10时,循环一直在进行,循环外部的打印任务是不会被执行的,当任务返回的a>=10时
// 循环结束,打印当前a的值,所以a是大于等于10的值!
- (void)testLog {
    __block NSInteger a = 0;
    while (a < 10) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            a++;
            NSLog(@"%ld == %@",a, [NSThread currentThread]);
        });
    };
    NSLog(@"循环外index == %ld",a);
}
// GCD
// 在iOS开发中，YYKit组件中的YYDispatchQueuePool也能控制并发队列的并发数；其思路是为不同优先级创建和 CPU 数量相同的 serial queue，每次从 pool 中获取 queue 时，会轮询返回其中一个 queue。

// 是使用信号量让并发队列中的任务并发数得到抑制；YYDispatchQueuePool是让一定数量的串行队列代替并发队列，避开了并发队列不好控制并发数的问题。
- (void)runMaxThreadCountWithGCD
{
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("concurrentRunMaxThreadCountWithGCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("serialRunMaxThreadCountWithGCD", DISPATCH_QUEUE_SERIAL);
    // 创建一个semaphore,并设置最大信号量，最大信号量表示最大线程数量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    // 使用循环往串行队列 serialQueue 增加 10 个任务
    for (int i = 0; i < 100 ; i++) {
        dispatch_async(serialQueue, ^{
            // 只有当信号量大于 0 的时候，线程将信号量减 1，程序向下执行
            // 否则线程会阻塞并且一直等待，直到信号量大于 0
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(workConcurrentQueue, ^{
                NSLog(@"%@ 执行任务一次  i = %d",[NSThread currentThread],i);
                sleep(1);
                // 当线程任务执行完成之后，发送一个信号，增加信号量。
                dispatch_semaphore_signal(semaphore);
            });
        });
    }
    NSLog(@"%@ 执行任务结束",[NSThread currentThread]);
}
// 任务分组
- (void)runGroupWithGCD
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("runGroupWithGCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group =  dispatch_group_create();
    for (int i = 0; i < 10 ; i++) {
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"%@ 执行任务一次",[NSThread currentThread]);
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%@ 执行任务结束",[NSThread currentThread]);
    });
}
// 任务分组 + 线程数量控制
- (void)runMaxCountInGroupWithGCD
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("runGroupWithGCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group =  dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    for (int i = 0; i < 10 ; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"%@ 执行任务一次",[NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"%@ 执行任务结束",[NSThread currentThread]);
    });
}
@end
