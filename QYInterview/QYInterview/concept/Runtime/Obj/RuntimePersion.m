//
//  RuntimePersion.m
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import "RuntimePersion.h"

@implementation RuntimePersion
+ (void)personClassMethod {
    NSLog(@"RuntimePersion 类方法");
}
// action 2 注释掉实现的代码
- (void)personInstanceMethod {
    NSLog(@"RuntimePersion 对象方法");
}
@end
