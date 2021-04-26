//
//  LoadPersion.m
//  QYInterview
//
//  Created by cyd on 2021/4/19.
//

#import "LoadPersion.h"

@implementation LoadPersion
+ (void)load {
    NSLog(@"LoadPersion load");
}
+ (void)initialize {
    // 子类未实现的话 会调用两次 一次为 LoadPersion 一次为 LoadSon
    NSLog(@"LoadPersion initialize");
}
@end
