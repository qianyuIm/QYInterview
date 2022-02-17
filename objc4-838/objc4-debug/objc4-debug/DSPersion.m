//
//  DSPersion.m
//  objc4-debug
//
//  Created by cyd on 2022/2/16.
//

#import "DSPersion.h"

@implementation DSPersion
+ (instancetype)persion {
    return [[DSPersion alloc] init];
}
- (void)dealloc {
    NSLog(@"溢出了");
}
@end
