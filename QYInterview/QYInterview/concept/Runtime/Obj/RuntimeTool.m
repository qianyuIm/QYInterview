//
//  RuntimeTool.m
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import "RuntimeTool.h"
#import <objc/runtime.h>

@implementation RuntimeTool

+ (void)qy_action1MethodSwizzlingWithClass:(Class)cls
                             oriSEL:(SEL)oriSEL
                        swizzledSEL:(SEL)swizzledSEL {
    if (!cls) NSLog(@"需要交换方法的类不能为nil");
    // 原来方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    // 交换的方法
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    // 交换
    method_exchangeImplementations(oriMethod, swizzledMethod);
}
+ (void)qy_action1BetterMethodSwizzlingWithClass:(Class)cls
                             oriSEL:(SEL)oriSEL
                                     swizzledSEL:(SEL)swizzledSEL {
    if (!cls) NSLog(@"需要交换方法的类不能为nil");
    // 原来方法
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    // 交换的方法
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    // 尝试添加
    BOOL success = class_addMethod(cls, oriSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(oriMethod));
    if (success) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
    
}
@end
