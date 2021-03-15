//
//  MemoryMigrationController.m
//  QYInterview
//
//  Created by cyd on 2021/3/15.
//

#import "MemoryMigrationController.h"

@interface MemoryMigrationPersion : NSObject
- (void)saySometing;
@end

@implementation MemoryMigrationPersion
- (void)saySometing {
    NSLog(@"说点什么好呢");
}

@end

@interface MemoryMigrationController ()

@end

@implementation MemoryMigrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    Class persion = [MemoryMigrationPersion class];
    void *obj = &persion;
    [(__bridge id)obj saySometing];
}

@end
