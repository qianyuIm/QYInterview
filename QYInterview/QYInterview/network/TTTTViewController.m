//
//  TTTTViewController.m
//  QYInterview
//
//  Created by cyd on 2021/1/13.
//

#import "TTTTViewController.h"
@interface Persion : NSObject
@property (nonatomic, assign) NSString *name;
@end

@implementation Persion
@end

@interface TTTTViewController ()
@property (nonatomic, assign) NSString *age;

@end

@implementation TTTTViewController
// https://blog.csdn.net/li15809284891/article/details/62896569?utm_medium=distribute.pc_relevant.none-task-blog-OPENSEARCH-8.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-OPENSEARCH-8.control

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.age = @"11岁";
    Persion *per1 = [[Persion alloc] init];
    __block Persion *per2 = [[Persion alloc] init];
    per1.name = @"first";
    per2.name = @"second";
    __block int index = 1;
    void (^handler)(NSString*) = ^(NSString *name){
        per1.name = name;
        per2.name = name;
        index = 2;
        self.age = @"15岁";
    };
    handler(@"three");
    NSLog(@"%@", per1.name);
    NSLog(@"%@", per2.name);
    NSLog(@"%i",index);
    NSLog(@"%@", self.age);
}


@end
