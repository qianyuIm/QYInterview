//
//  ViewController.m
//  Touch
//
//  Created by cyd on 2022/2/17.
//

#import "ViewController.h"
#import "DSPersion.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DSPersion *persion = [[DSPersion alloc] init];
//    persion.name = @"123";
    NSLog(@"%@",persion);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"触摸 ------ ViewController -> View");
    
}

@end
