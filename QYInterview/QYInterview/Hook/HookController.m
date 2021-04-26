//
//  HookController.m
//  QYInterview
//
//  Created by cyd on 2021/3/2.
//

#import "HookController.h"
#import <PandaHook/PandaHook.h>
#import <SDMagicHook/SDMagicHook.h>
#import <Aspects/Aspects.h>


@implementation HookBase
- (void)log {
    NSLog(@"我只是个HookBase%@",self);
    [HookBase heheda];
}
+ (void)heheda {
    HookBase *base = [HookBase new];
    [base log];
}
@end


@implementation HookPersion
//@synthesize age = _age;

//@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
        self.age = @"";
        self.name = @"";
    }
    return self;
}
//- (void)setName:(NSString *)name {
//    _name = name;
//}
- (void)setAge:(NSString *)age {
    _age = age;
}
- (void)log {
    NSLog(@"我只是个HookPersion%@",self);
}
@end

@interface HookController ()
@property (nonatomic, strong) HookBase *base;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation HookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _base = [[HookBase alloc] init];
    [_base hookMethod:@selector(setName:) impBlock:^(HookBase *base, NSString *name){
        [base callOriginalMethodInBlock:^{
             [base setName:name];
        }];
    }];
}
// 一次Hook
- (IBAction)onceHook:(UIButton *)sender {
    _array = [NSMutableArray array];
    HookPersion *persion = [[HookPersion alloc] init];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
    
}


    

@end
