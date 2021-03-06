//
//  IfElseController.m
//  QYInterview
//
//  Created by cyd on 2021/2/23.
//

#import "IfElseController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface IfElseController ()

@end

@implementation IfElseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self example1];
    [self example1Optimize];
}
// 例子1： 根据status的值判断对应的result的值
- (void)example1 {
    NSString *status = @"1";
    NSString *result = @"";
    if ([status isEqual:@"0"]) {
        result = @"0000";
    } else if ([status isEqual:@"1"]) {
        result = @"1111";
    } else if ([status isEqual:@"2"]) {
        result = @"2222";
    } else if ([status isEqual:@"3"]) {
        result = @"3333";
    } else if ([status isEqual:@"4"]) {
        result = @"4444";
    } else if ([status isEqual:@"5"]) {
        result = @"5555";
    } else if ([status isEqual:@"6"]) {
        result = @"6666";
    }
    NSLog(@"result = %@",result);
}
// 表驱动法
- (void)example1Optimize {
    NSString *status = @"1";
    NSString *result = @"";
    NSDictionary *dic = @{@"0": @"0000",
                          @"1": @"1111",
                          @"2": @"2222",
                          @"3": @"3333",
                          @"4": @"4444",
                          @"5": @"5555",
                          @"6": @"6666"};
        
    result =  dic[status];
    NSLog(@"result = %@",result);
}

@end
