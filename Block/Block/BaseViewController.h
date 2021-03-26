//
//  BaseViewController.h
//  Block
//
//  Created by cyd on 2021/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#ifdef DEBUG
#define QYNSLog(format, ...) printf("%s\n", [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define QYNSLog(format, ...);
#endif
@interface BaseViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
