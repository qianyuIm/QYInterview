//
//  ViewController.m
//  Performance
//
//  Created by cyd on 2021/4/15.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200.33333, 100, 100, 50)];
    label.text = @"我是文字";
    
    [self.view addSubview:label];

    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(10.4, 200, 100, 100)];
//    myView.alpha = 0.5;
    myView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:myView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, 200, 184)];
    UIImage *image = [UIImage imageNamed:@"headImg@2x.jpg"];
    imageView.image = image;
    [self.view addSubview:imageView];

}


@end
