//
//  BlockChangeController.m
//  QYInterview
//
//  Created by cyd on 2021/1/14.
//  https://blog.csdn.net/li15809284891/article/details/62896569?utm_medium=distribute.pc_relevant.none-task-blog-OPENSEARCH-8.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-OPENSEARCH-8.control

#import "BlockChangeController.h"
int global_value = 10;
static int global_static_value = 10;
typedef void (^ChangeValueBlock) (void);
@interface BlockPersion : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation BlockPersion

@end

@interface BlockChangeController ()
@property (nonatomic, retain) ChangeValueBlock retainBlock;
@end

@implementation BlockChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    BlockPersion *persion = [[BlockPersion alloc] init];
    persion.name = @"xiao ming";
    static int static_value = 10;
    int value = 10;
    __block int block_value = 10;
    NSMutableArray *array = [NSMutableArray array];
    ChangeValueBlock block1 = ^{
        // 改变
        persion.name = @"xiao hong";
        // 改变
        global_value = 30;
        // 改变
        global_static_value = 30;
        // 改变
        static_value = 30;
//        value = 30;
        // 改变
        block_value = 30;
        // 可以调用对象的方法
        [array addObject:@"xiao hu"];
//        array = nil;
//        persion = nil;
        NSLog(@"value2 = %d",value);
    };
    value = 20;
    NSLog(@"value1 = %d",value);
    
    int(^sum)(int, int) = ^(int a, int b) {
        return a + b;
    };

    // NSMallocBlock
    block1();
    // NSGlobalBlock
    sum(1,2);
    // ARC下为 NSMallocBlock MRC下为 NSStackBlock
    NSArray *testArr = @[@"1", @"2"];
    void (^TestBlock)(void) = ^{
        NSLog(@"testArr :%@", testArr);
    };
    NSLog(@"block is %@", ^{
        NSLog(@"test Arr :%@", testArr);
    });
    NSLog(@"block is %@", TestBlock);

    _retainBlock = ^{
        NSLog(@"我是retain block%@",persion.name);
    };
    _retainBlock();
}
/* 1. NSGlobalBlock: 类似函数，位于text段，未引用外部变量为 NSGlobalBlock
 * 2. NSStackBlock： 位于栈内存，函数返回后block无效
 * 3. NSMallocBlock： 位于堆内存
 *
 *
 *
 */

@end
