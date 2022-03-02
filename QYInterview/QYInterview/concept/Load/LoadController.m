//
//  LoadController.m
//  QYInterview
//
//  Created by cyd on 2021/4/19.
//

#import "LoadController.h"
#import "LoadPersion.h"
#import "LoadSon.h"
#import "LoadPersion+add.h"
#import "LoadPersion+sub.h"
#import "LoadSon+add.h"
#import "LoadSon+sub.h"
#import "LoadPersion+LoadPersion_E.h"

/**
 + load  父类 -> 子类 - 父类分类(源文件顺序) -> 子类分类(源文件顺序)
 + initialize
 */
@interface LoadController ()

@end

@implementation LoadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    LoadPersion *persion = [LoadPersion new];
    LoadSon *son = [LoadSon new];
//    persion.name = @"23";
//    son.name = @"14";
    NSLog(@"%@",persion.name);
    NSLog(@"%@",son.name);

//    [persion eat];
}
@end
