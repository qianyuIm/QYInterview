//
//  MemoryMigrationController.m
//  QYInterview
//
//  Created by cyd on 2021/3/15.
//

#import "MemoryMigrationController.h"

@interface MemoryMigrationPersion : NSObject
@property (nonatomic, copy) NSString *ds_name;
@property (nonatomic, assign) int ds_age;

- (void)saySometing;
@end

@implementation MemoryMigrationPersion
- (void)saySometing {
    // 0
    NSLog(@"说点什么好呢 -> %d",self.ds_age);
    // 坏内存访问
    NSLog(@"说点什么好呢 -> %@",self.ds_age);
    
}

@end

@interface MemoryMigrationController ()

@end

@implementation MemoryMigrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Class cls = [MemoryMigrationPersion class];
    MemoryMigrationPersion *persion = [MemoryMigrationPersion alloc];

    void *obj = &cls;
//    [(__bridge id)obj saySometing];
    [persion saySometing];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    
}

@end
