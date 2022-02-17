//
//  ViewController.m
//  Touch
//
//  Created by cyd on 2022/2/17.
//

#import "ViewController.h"
#import "MyView1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyView1 *myView1 = [[MyView1 alloc] init];
    [myView1 setValue:@"123" forKey:@"name"];
    NSLog(@"%@",myView1.name);
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
    NSLog(@"触摸 ------ ViewController -> View");
    
}

@end
