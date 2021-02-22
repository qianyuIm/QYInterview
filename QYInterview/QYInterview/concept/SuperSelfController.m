//
//  SuperSelfController.m
//  QYInterview
//
//  Created by cyd on 2021/2/22.
//  https://www.jianshu.com/p/57e3f555756e

#import "SuperSelfController.h"
typedef void(^Block)(void);
@interface SuperSelfPersion : NSObject
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *name;

- (void)run;
@end

@implementation SuperSelfPersion
- (void)run {
    NSLog(@"%@ -- run",self.name);
}
- (void)dealloc {
    NSLog(@"%@销毁了",self);
}
@end

@interface SuperSelfStudent : SuperSelfPersion

@end

@implementation SuperSelfStudent
- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"[self class] = %@", [self class]);
        NSLog(@"[self superclass] = %@", [self superclass]);
        NSLog(@"----------------");
        NSLog(@"[super class] = %@", [super class]);
        NSLog(@"[super superclass] = %@", [super superclass]);
    }
    return self;
}
- (void)run {
    [super run];
    NSLog(@"%@ == run",self.name);
}
/*
static void _I_SuperSelfStudent_run(SuperSelfStudent * self, SEL _cmd) {
    
    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("SuperSelfStudent"))}, sel_registerName("run"));
    
    
    NSLog((NSString *)&__NSConstantStringImpl__var_folders_jm_dztwxsdn7bvbz__xj2vlp8980000gn_T_Student_e677aa_mi_0);
}
OBJC_EXPORT id _Nullable
objc_msgSendSuper(struct objc_super * _Nonnull super, SEL _Nonnull op, ...)
    OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0, 2.0);
// 精简后的objc_super结构体
struct objc_super {
    __unsafe_unretained _Nonnull id receiver; // 消息接受者
    __unsafe_unretained _Nonnull Class super_class; // 消息接受者的父类
    // super_class is the first class to search
    // 父类是第一个开始查找的类
};*/
@end

@interface SuperSelfController ()

@end

@implementation SuperSelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // int占用4个字节
//    int a = 3;
    NSObject *obj1 = [[NSObject alloc] init];
    id cls = [SuperSelfPersion class];
    void *obj = &cls;
    [(__bridge id)obj run];
//    SuperSelfPersion *person = [[SuperSelfPersion alloc] init];
//    [person run];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *array = [NSMutableArray array];
    Block block = ^{
        [array addObject: @"5"];
        [array addObject: @"5"];
        NSLog(@"%@",array);
    };
    block();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self performSelectorOnMainThread:@selector(test) withObject:nil waitUntilDone:YES];
        [self performSelector:@selector(test) withObject:nil];
    });
    
}
- (void)test {
    SuperSelfPersion *person = [[SuperSelfPersion alloc] init];
    __weak SuperSelfPersion *waekP = person;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"person ----- %@",person);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"weakP ----- %@",waekP);
        });
    });
    NSLog(@"touchBegin----------End");
}
@end
