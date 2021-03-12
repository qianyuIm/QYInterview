//
//  SwizzlingController.m
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import "SwizzlingController.h"
#import "RuntimePersion.h"
#import "RuntimeStudent.h"

@interface SwizzlingController ()

@end

@implementation SwizzlingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
// 子类没实现，父类实现了 然后子类分类中做方法交换
- (IBAction)action1:(UIButton *)sender {
    RuntimeStudent *student = [[RuntimeStudent alloc] init];
    [student personInstanceMethod];
    
    RuntimePersion *persion = [[RuntimePersion alloc] init];
    [persion personInstanceMethod];
    
}
// 子类和父类都没有实现，只是声明,会造成死循环
- (IBAction)action2:(UIButton *)sender {
    RuntimeStudent *student = [[RuntimeStudent alloc] init];
    [student personInstanceMethod];
    
    RuntimePersion *persion = [[RuntimePersion alloc] init];
    [persion personInstanceMethod];
}


@end
