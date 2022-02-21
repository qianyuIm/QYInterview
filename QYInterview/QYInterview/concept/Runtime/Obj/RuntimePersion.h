//
//  RuntimePersion.h
//  QYInterview
//
//  Created by cyd on 2021/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimePersion : NSObject
@property (nonatomic, copy) NSString *name;
+ (void)personClassMethod;
- (void)personInstanceMethod;

@end

NS_ASSUME_NONNULL_END
