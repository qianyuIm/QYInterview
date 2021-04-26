//
//  HookController.h
//  QYInterview
//
//  Created by cyd on 2021/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHHH <NSObject>

@property (nonatomic, copy) NSString *HHHHName;

@end

@interface HookBase : NSObject 
@property (nonatomic, copy) NSString *name;
- (void)log;
@end

@interface HookPersion : HookBase
@property (nonatomic, copy) NSString *age;

@end

@interface HookController : UIViewController<HHHH>

@end

NS_ASSUME_NONNULL_END
