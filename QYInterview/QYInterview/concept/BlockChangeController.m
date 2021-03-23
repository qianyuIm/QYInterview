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
- (void)eat;
@end
@implementation BlockPersion
- (void)eat {
    NSLog(@"吃东西");
}
- (void)dealloc {
    NSLog(@"移除了");
}
@end

@interface BlockChangeController ()
@property (nonatomic, retain) ChangeValueBlock retainBlock;
@property (nonatomic, strong) NSArray *array;

@end

@implementation BlockChangeController
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s",dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    NSLog(@"%s",dispatch_queue_get_label(dispatch_get_main_queue()));

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
    
    NSString *str1 = @"123";
    NSString *str2 = str1;
    str2 = @"456";
    NSLog(@"str1 = %@ -- str2 = %@", str1, str2);
    NSLog(@"%p",&str1);
    NSLog(@"%p",&str2);
    
    BlockPersion *obj1 = [BlockPersion alloc];
    obj1.name = @"123";
    BlockPersion *p1 = [obj1 init];
    BlockPersion *p2 = [obj1 init];
    NSLog(@"%@ - %@ - %@", obj1, p1, p2);
    NSLog(@"%p - %p - %p", obj1, p1, p2);
    NSLog(@"%p - %p - %p", &obj1, &p1, &p2);

    
//    __autoreleasing UIView* myView;
//    @autoreleasepool {
//        myView = [UIView new];
//        NSLog(@"inside autoreleasepool myView:%@", myView);
//    }
//    NSLog(@"outside autoreleasepool myView:%@", myView);


}
/* 1. NSGlobalBlock: 类似函数，位于text段，未引用外部变量为 NSGlobalBlock
 * 2. NSStackBlock： 位于栈内存，函数返回后block无效
 * 3. NSMallocBlock： 位于堆内存
 *
 *
 *
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"qwer");
//    NSArray *array1 = [NSArray new];
//    void (^TestBlock)(void) = ^{
////        [array1 addObject:@1];
//        array1 = @[@1];
//        NSLog(@"testArr :%@", array1);
//    };
//    TestBlock();
//    NSLog(@"testArr :%@", array1);
    
}
@end
