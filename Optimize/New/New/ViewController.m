//
//  ViewController.m
//  New
//
//  Created by cyd on 2021/4/14.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface Persion : NSObject

@end

@implementation Persion



@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Persion *per = [Persion new];
    NSLog(@"%@",[per class]);
    NSLog(@"%@",object_getClass(per));

    NSLog(@"%@",[Persion class]);
//    NSLog(@"%@",object_getClass(Persion));

    
}


@end
