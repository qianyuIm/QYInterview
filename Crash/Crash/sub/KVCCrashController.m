//
//  KVCCrashController.m
//  Crash
//
//  Created by cyd on 2021/3/30.
//

#import "KVCCrashController.h"
@interface KVCCrashItem : NSObject
@property (nonatomic, strong) NSString *name;

@end

@implementation KVCCrashItem


@end
@interface KVCCrashController ()

@end

@implementation KVCCrashController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    KVCCrashItem *item = [[KVCCrashItem alloc] init];
    [item setValue:@"123" forKey:@"name"];
    [item setValue:nil forKey:@"name"];
    [item setValue:@"123" forKey:nil];
    [item setValue:@"123" forKey:@"fasleKey"];


}

@end
