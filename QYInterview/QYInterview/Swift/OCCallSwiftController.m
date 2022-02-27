//
//  OCCallSwiftController.m
//  QYInterview
//
//  Created by 丁帅 on 2022/2/27.
//

#import "OCCallSwiftController.h"
#import "QYInterview-Swift.h"
@interface OCCallSwiftController ()

@end

@implementation OCCallSwiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [OCCallSwift log];
    NSLog(@"需要引入#import QYInterview-Swift.h头文件，https://www.jianshu.com/p/05fa12be364b ");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
