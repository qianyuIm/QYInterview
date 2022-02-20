//
//  DSPersion.h
//  Touch
//
//  Created by 丁帅 on 2022/2/17.
//

#import <Foundation/Foundation.h>

@protocol DSPersonProtocol <NSObject>
@property (nonatomic, copy) NSString *name111;
@end

NS_ASSUME_NONNULL_BEGIN

@interface DSPersion : NSObject<DSPersonProtocol>

@end

NS_ASSUME_NONNULL_END
