//
//  RuntimePersion.m
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import "RuntimePersion.h"

@implementation RuntimePersion
@synthesize name = _name;
+ (void)personClassMethod {
    NSLog(@"RuntimePersion 类方法");
}
// action 2 注释掉实现的代码
- (void)personInstanceMethod {
    NSLog(@"RuntimePersion 对象方法");
}
-(void)setName:(NSString *)name {
    _name = name;
}
- (NSString *)name {
    return _name;
}
@end
