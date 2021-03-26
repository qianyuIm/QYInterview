//
//  MRCController.m
//  Block
//
//  Created by cyd on 2021/3/25.
//

#import "MRCController.h"

@interface MRCController ()

@end

@implementation MRCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"block直接存储在全局区;如果block访问外界变量，并进行block相应拷贝，即copy操作;如果此时的block是强引用，则block存储在堆区，即堆区block;如果此时的block通过__weak变成了弱引用，则block存储在栈区，即栈区block";
    NSLog(@"总结： -------\n %@",str);
    
}
#pragma mark - 全局
static int globalNum = 10;
- (IBAction)blockGlobal:(id)sender {
    void (^GlobalBlock)(int num) = ^(int num){
        NSLog(@"123 %d %d",globalNum, num);
    };
    GlobalBlock(100);
    NSLog(@"%@",GlobalBlock);
}
#pragma mark - 栈区
- (IBAction)blockStack:(id)sender {
    [self cj_testStackBlock];
    [self cj_testStackBlock1];

}
- (void)cj_testStackBlock{
    int a = 10;
    QYNSLog(@"%@", ^{
        NSLog(@"hello - %d", a);
   });
    NSLog(@"%@", ^{
        NSLog(@"hello - %d", a);
   });
}
- (void)cj_testStackBlock1{
    int a = 10;
   void(^__weak block)(void) = ^{
       QYNSLog(@"hello - %d", a);
   };
    QYNSLog(@"%@", block);
}
#pragma mark - 堆区
- (IBAction)blockMalloc:(id)sender {
    int num = 0;
    void (^MallocBlock)(void) = ^{
        NSLog(@"num = %d",num);
    };
    MallocBlock();
    NSLog(@"%@",MallocBlock);

}



@end
