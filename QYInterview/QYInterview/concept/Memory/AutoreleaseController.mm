//
//  AutoreleaseController.m
//  QYInterview
//
//  Created by cyd on 2021/3/11.
//

#import "AutoreleaseController.h"

@interface AutoreleasePersion : NSObject
+ (instancetype)persion;
@end

@implementation AutoreleasePersion
+ (instancetype)persion {
    return [[self alloc] init];
}
- (void)dealloc {
    NSLog(@"被释放了");
}
@end

@interface AutoreleaseController ()
@end

@implementation AutoreleaseController
struct QYTest {
    QYTest() {
        index = 10;
        NSLog(@"%d",index);
    }
    ~QYTest() {
        index = 20;
        NSLog(@"%d",index);
    }
    int index;
};
__weak id reference = nil;
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %@", reference);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    AutoreleasePersion *persion = [AutoreleasePersion persion];
    AutoreleasePersion *persion = [[AutoreleasePersion alloc] init];

    NSLog(@"viewDidLoad %@", persion);

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %@", reference);
}
__weak id temp = nil;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    __autoreleasing AutoreleasePersion *persion = [[AutoreleasePersion alloc] init];
    temp = persion;
}
@end
