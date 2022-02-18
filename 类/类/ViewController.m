//
//  ViewController.m
//  类
//
//  Created by cyd on 2022/2/18.
//

#import "ViewController.h"
#import "DSPersion.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self getContent];
}
- (void)getContent {
    DSPersion *persion = [[DSPersion alloc] init];
    persion.num = [NSString stringWithFormat:@"abcdefghijklmnop"];
    
}
- (void)getSize {
    DSPersion *persion = [[DSPersion alloc] init];
    // 8 字节对齐
    size_t instanceSize = class_getInstanceSize([persion class]);
    NSLog(@"instanceSize -> %zd",instanceSize);
    // 16 字节对齐 实际分配的内存大小
    size_t mallocSize = malloc_size((__bridge const void*)persion);
    NSLog(@"mallocSize -> %zd",mallocSize);
    // sizeof 只会计算类型所占用的内存大小，不会关心具体的对象的内存布局；
    size_t size = sizeof(persion);
    NSLog(@"sizeof -> %zd",size);
}

@end
