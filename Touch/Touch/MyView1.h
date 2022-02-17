//
//  MyView1.h
//  Touch
//
//  Created by cyd on 2022/2/17.
//

#import <UIKit/UIKit.h>
@protocol PersonProtocol <NSObject>
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_BEGIN

@interface MyView1 : UIView<PersonProtocol>

@end

NS_ASSUME_NONNULL_END
