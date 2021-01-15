//
//  KVOController.m
//  QYInterview
//
//  Created by cyd on 2021/1/15.
//

#import "KVOController.h"

@interface KVOPersion : NSObject
{
    @public NSString *_sex;
}
@property (nonatomic, copy) NSString *name;
@end

@implementation KVOPersion
- (void)setName:(NSString *)name {
    _name = name;
    NSLog(@"name = %@",name);
}
@end

@interface KVOController ()
@property (nonatomic, strong) KVOPersion *persion;

@end

@implementation KVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _persion = [[KVOPersion alloc] init];
    [_persion addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    _persion.name = @"xiao hu";
    _persion->_sex = @"nan";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    _persion.name = @"xiao ming";
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath = %@, change = %@",keyPath, change);
}
@end
