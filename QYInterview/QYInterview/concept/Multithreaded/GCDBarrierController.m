//
//  GCDBarrierController.m
//  QYInterview
//
//  Created by cyd on 2021/3/10.
//

#import "GCDBarrierController.h"

@interface GCDBarrierPersion : NSObject
@property (nonatomic, strong) NSMutableDictionary *userCenterDic;
@property (nonatomic, strong) dispatch_queue_t synchronizationQueue;

@end

@implementation GCDBarrierPersion

- (instancetype)init
{
    self = [super init];
    if (self) {
        _synchronizationQueue = dispatch_queue_create("com.barrier.barrierPersion", DISPATCH_QUEUE_CONCURRENT);
        _userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setSafeObject:(NSString*)obj forKey:(NSString*)key sleepIn:(unsigned int)slee callBack:(void(^)(void))callBack {
    key = [key copy];
    dispatch_barrier_async(_synchronizationQueue, ^{
        sleep(slee);
        [self.userCenterDic setObject:obj forKey:key];
        callBack();
    });
}
- (NSString*)safeObjectForKey:(NSString*)key {
    __block NSString *temp;
    // 同步读取指定数据
    dispatch_sync(_synchronizationQueue, ^{
        temp = [_userCenterDic objectForKey:key];
    });
    return temp;
}
@end

@interface GCDBarrierController ()

@end

@implementation GCDBarrierController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:@"123" object:nil];
}
- (void)notification {
    NSLog(@"%@",[NSThread currentThread]);
}
// 普通
- (IBAction)normalAction:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.barrier.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_async(queue, ^{
        NSLog(@"3");
    });
    dispatch_barrier_async(queue, ^{
        sleep(2);
        NSLog(@"5");
    });
    dispatch_async(queue, ^{
        NSLog(@"4");
    });
}
// 多读单写
- (IBAction)multiReadSingleWriteAction:(UIButton *)sender {
    dispatch_queue_t queue1 = dispatch_queue_create("com.barrier.concurrent1", DISPATCH_QUEUE_CONCURRENT);
    GCDBarrierPersion *persion = [[GCDBarrierPersion alloc] init];
    dispatch_async(queue1, ^{
        NSLog(@"1开始");
        [persion setSafeObject:@"1" forKey:@"name" sleepIn:3 callBack:^{
            NSLog(@"1结束");
        }];
//        NSLog(@"1 - %@ ----- %@",persion.userCenterDic,[NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NSLog(@"2开始");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:nil];
        [persion setSafeObject:@"2" forKey:@"name" sleepIn:1 callBack:^{
            NSLog(@"2结束");
        }];
//        NSLog(@"2 - %@ ----- %@",persion.userCenterDic,[NSThread currentThread]);
    });
    dispatch_async(queue1, ^{
        NSLog(@"3开始");
        [persion setSafeObject:@"3" forKey:@"name" sleepIn:1 callBack:^{
            NSLog(@"3结束");
        }];
//        NSLog(@"3 - %@ ----- %@",persion.userCenterDic,[NSThread currentThread]);
    });
//    dispatch_async(queue1, ^{
//        NSString *name = [persion safeObjectForKey:@"name"];
//        NSLog(@"4 name = %@ %@",name, persion.userCenterDic);
//    });
}
// 单读单写
- (IBAction)singleReadSingleWriteAction:(UIButton *)sender {
    GCDBarrierPersion *persion = [[GCDBarrierPersion alloc] init];
    NSString *name = [persion safeObjectForKey:@"name"];
}


@end
