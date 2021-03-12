//
//  RuntimeTool.h
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeTool : NSObject
+ (void)qy_action1MethodSwizzlingWithClass:(Class)cls
                             oriSEL:(SEL)oriSEL
                        swizzledSEL:(SEL)swizzledSEL;
+ (void)qy_action1BetterMethodSwizzlingWithClass:(Class)cls
                             oriSEL:(SEL)oriSEL
                        swizzledSEL:(SEL)swizzledSEL;
@end

NS_ASSUME_NONNULL_END
