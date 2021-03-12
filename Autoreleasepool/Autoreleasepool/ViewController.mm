//
//  ViewController.m
//  Autoreleasepool
//
//  Created by cyd on 2021/3/11.
//

#import "ViewController.h"
struct QYTest {
    QYTest() {
        index = 10;
        NSLog(@"%d",index);
    }
    ~QYTest() {
        index = 20;
        NSLog(@"%d",index);
    }
    int index;
};
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"开始");
    {
        QYTest test;
    }
    NSLog(@"结束");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    @autoreleasepool {
        NSLog(@"自动释放池");
    }
}

@end
