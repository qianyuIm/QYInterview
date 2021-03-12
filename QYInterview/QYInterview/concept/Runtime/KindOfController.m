//
//  KindOfController.m
//  QYInterview
//
//  Created by cyd on 2021/3/10.
//

#import "KindOfController.h"
#import "RuntimePersion.h"

@interface KindOfController ()

@end

@implementation KindOfController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[RuntimePersion class] isKindOfClass:[RuntimePersion class]];
    BOOL res4 = [(id)[RuntimePersion class] isMemberOfClass:[RuntimePersion class]];
    NSLog(@"== %d",res1);
    NSLog(@"== %d",res2);
    NSLog(@"== %d",res3);
    NSLog(@"== %d",res4);
}


@end
