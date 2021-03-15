//
//  KindOfController.m
//  QYInterview
//
//  Created by cyd on 2021/3/10.
//

#import "KindOfController.h"
#import "RuntimePersion.h"

@interface KindOfController ()

@end

@implementation KindOfController
// https://www.jianshu.com/p/bbe1ca18e7dc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    // 相当于 NSObject 的元类 isKindOfClass NSObject 类对象
    // NSObject 的元类 的父类为  NSObject类
    // 所以为 NSObject 类对象 isKindOfClass NSObject 类对象  == 1
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
    // 相当于 NSObject 的元类 isMemberOfClass NSObject 类对象  == 0
    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
    // RuntimePersion 的元类 isKindOfClass RuntimePersion 类对象
    // RuntimePersion 元类的父类 根元类 isKindOfClass RuntimePersion 类对象
    // 根元类 的父类为 NSObject 类对象 isKindOfClass RuntimePersion 类对象 == 0
    BOOL res3 = [[RuntimePersion class] isKindOfClass:[RuntimePersion class]];
    // RuntimePersion 的元类 isMemberOfClass RuntimePersion 类对象 == 0
    BOOL res4 = [[RuntimePersion class] isMemberOfClass:[RuntimePersion class]];
    // 1 0 0 0
    NSLog(@"%d %d %d %d", res1, res2, res3, res4);
    // NSObject 实例对象的 class 指向 NSObject元类 isKindOfClass NSObject类对象
    // NSObject 类对象 isKindOfClass NSObject 类对象 == 1
    BOOL res5 = [[[NSObject new] class] isKindOfClass:[NSObject class]];
    // NSObject 实例对象的 class 指向 NSObject元类 isMemberOfClass NSObject 类对象 == 0
    BOOL res6 = [[[NSObject new] class] isMemberOfClass:[NSObject class]];
    // RuntimePersion 实例对象的 class RuntimePersion 元类 isKindOfClass RuntimePersion类对象
    // NSObject 类对象 isKindOfClass RuntimePersion类对象 == 0
    BOOL res7 = [[[RuntimePersion new] class] isKindOfClass:[RuntimePersion class]];
    // RuntimePersion 实例对象的 class RuntimePersion 元类 isMemberOfClass RuntimePersion 类对象  == 0
    BOOL res8 = [[[RuntimePersion new] class] isMemberOfClass:[RuntimePersion class]];
    // 1 0 0 0
    NSLog(@"%d %d %d %d", res5, res6, res7, res8);
    // NSObject实例变量 isKindOfClass NSObject 类对象
    // NSObject类对象 isKindOfClass NSObject类对象 == 1
    BOOL res9 = [[NSObject new] isKindOfClass:[NSObject class]];
    // NSObject实例变量 isMemberOfClass NSObject 类对象
    // NSObject类对象 isMemberOfClass NSObject类对象 == 1
    BOOL res10 = [[NSObject new] isMemberOfClass:[NSObject class]];
    // RuntimePersion 实例变量 isMemberOfClass RuntimePersion 类对象
    // RuntimePersion类对象 isKindOfClass RuntimePersion类对象 == 1
    BOOL res11 = [[RuntimePersion new] isKindOfClass:[RuntimePersion class]];
    BOOL res12 = [[RuntimePersion new] isMemberOfClass:[RuntimePersion class]];
    // 1 1 1 1
    NSLog(@"%d %d %d %d", res9, res10, res11, res12);
}

@end
