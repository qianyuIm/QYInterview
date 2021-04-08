//
//  KVOCrashController.m
//  Crash
//
//  Created by cyd on 2021/3/30.
//

#import "KVOCrashController.h"
@interface KVOCrashItem : NSObject
@property (nonatomic, strong) NSString *name;

@end

@implementation KVOCrashItem

@end

@interface KVOCrashPersion : NSObject
@property (nonatomic, strong) KVOCrashItem *crashItem;
@property (nonatomic, copy) NSString *name;

@end

@implementation KVOCrashPersion
- (instancetype)init {
    if (self = [super init]) {
        self.crashItem = [[KVOCrashItem alloc] init];
    }
    return  self;
}
@end

@interface KVOCrashController ()
@property (nonatomic, strong) KVOCrashPersion *persion;

@end

@implementation KVOCrashController
- (void)dealloc {
    // 苹果内部做了安全操作
    [self.persion removeObserver:self forKeyPath:@"name"];
    [self.persion removeObserver:self forKeyPath:@"name"];
    [self.persion removeObserver:self forKeyPath:@"name"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
//    self.persion = [[KVOCrashPersion alloc] init];
//    [self.persion addObserver:self
//              forKeyPath:@"name"
//                 options:NSKeyValueObservingOptionNew
//                 context:nil];
//    self.persion.name = @"";
    
    BaseViewController *vc = [[BaseViewController alloc] init];
    for (int index = 0; index < 10; index++) {
        vc.navigationItem.title = [NSString stringWithFormat:@"%d",index];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ --- %@", keyPath, change);
}
@end
