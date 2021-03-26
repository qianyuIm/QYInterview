//
//  CopyController.m
//  QYInterview
//
//  Created by cyd on 2021/3/26.
//

#import "CopyController.h"

@interface CopyController ()

@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) NSArray *strongArray;

@property (nonatomic, copy) NSMutableArray *mutableArray;
@property (nonatomic, strong) NSMutableArray *strongMutableArray;

@end

@implementation CopyController
// 结论： NSArray使用copy修饰 防止因为使用 NSMutableArray赋值导致NSArray变化的问题
// NSMutableArray 使用 copy修饰生成不可变的 NSArray 增删改查会导致闪退

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    [self testArray];
    [self testMutableArray];

}
#pragma mark - 测试array
- (void)testArray {
    NSMutableArray *muArray = [NSMutableArray arrayWithObject:@1];
    self.array = [NSArray array];
    self.strongArray = [NSArray array];
    
    self.array = muArray;
    self.strongArray = muArray;
    NSLog(@"copy = %@ -- strong = %@", self.array, self.strongArray);
    [muArray addObject:@2];
    NSLog(@"copy = %@ -- strong = %@", self.array, self.strongArray);


}
#pragma mark - 测试MutableArray
- (void)testMutableArray {
    self.mutableArray = [NSMutableArray array];
    self.strongMutableArray = [NSMutableArray array];
    
    NSLog(@"mutableArray class = %@",[self.mutableArray class]);
    NSLog(@"strongMutableArray class = %@",[self.strongMutableArray class]);
    [self.mutableArray addObject:@2];
    [self.strongMutableArray addObject:@2];

}
@end
