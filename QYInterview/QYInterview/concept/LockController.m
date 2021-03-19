//
//  LockController.m
//  QYInterview
//
//  Created by cyd on 2021/3/19.
//

#import "LockController.h"

@interface LockController ()
@property (nonatomic, strong) NSMutableArray *testArray;
@end

@implementation LockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - NSLock
- (IBAction)nsLockAction:(id)sender {
    self.testArray = [NSMutableArray array];
    NSLock *lock = [[NSLock alloc] init];
    for (int i = 0; i < 2000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [lock lock];
            @synchronized (self.testArray) {
                
                self.testArray = [NSMutableArray array];
            }
//            [lock unlock];
        });
    }
    // 被锁定
    /*NSLock *lock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void (^block)(int);
        block = ^(int value) {
            NSLog(@"加锁前");
            [lock lock];
            NSLog(@"加锁后");
            if (value > 0) {
                NSLog(@"value——%d", value);
                block(value - 1);
            }
            [lock unlock];
        };
        block(10);
    });*/

    
}


@end
