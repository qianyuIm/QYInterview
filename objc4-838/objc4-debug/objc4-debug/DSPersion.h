//
//  DSPersion.h
//  objc4-debug
//
//  Created by cyd on 2022/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSPersion : NSObject
@property (atomic, strong) NSString *nickName;
+ (instancetype)persion;
@end

NS_ASSUME_NONNULL_END