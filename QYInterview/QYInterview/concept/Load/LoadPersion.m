//
//  LoadPersion.m
//  QYInterview
//
//  Created by cyd on 2021/4/19.
//

#import "LoadPersion.h"
#import "LoadPersion+LoadPersion_E.h"
@interface LoadPersion ()

@end

@implementation LoadPersion
- (instancetype)init {
    if (self = [super init]) {
        self.name = @"123";
    }
    return  self;
}
+ (void)load {
    NSLog(@"LoadPersion load");
}
+ (void)initialize {
    // 子类未实现的话 会调用两次 一次为 LoadPersion 一次为 LoadSon
    NSLog(@"LoadPersion initialize");
}
@end
