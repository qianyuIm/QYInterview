//
//  RuntimeStudent+QY.m
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import "RuntimeStudent+QY.h"
#import "RuntimeTool.h"

@implementation RuntimeStudent (QY)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [RuntimeTool qy_action1MethodSwizzlingWithClass:self oriSEL:@selector(personInstanceMethod) swizzledSEL:@selector(qy_studentInstanceMethod)];
        [RuntimeTool qy_action1BetterMethodSwizzlingWithClass:self oriSEL:@selector(personInstanceMethod) swizzledSEL:@selector(qy_studentInstanceMethod)];
    });
}
- (void)qy_studentInstanceMethod {
    // 调用原方法
    [self qy_studentInstanceMethod];
    NSLog(@"RuntimeStudent 添加一个对象方法");
}

@end
