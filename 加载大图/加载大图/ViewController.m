//
//  ViewController.m
//  加载大图
//
//  Created by cyd on 2022/2/16.
//

#import "ViewController.h"

typedef void(^RunloopBlock)(void);
static NSString *Identifier = @"123";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// 任务
@property (nonatomic, strong) NSMutableArray *tasks;
// 最大任务数
@property (nonatomic, assign) NSUInteger maxQueueLength;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tasks = [NSMutableArray array];
    _maxQueueLength = 28;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    
    [self addRunloopObserver];

    
}
- (void)timerMethod {
//    NSLog(@"q");
}
static void TaskCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
//    NSLog(@"我来了");
    // 取出任务执行
    ViewController *vc = (__bridge ViewController*)info;
    if (vc.tasks.count == 0) {
        return;
    }
    // 取出任务执行
    RunloopBlock task = vc.tasks.firstObject;
    task();
    [vc.tasks removeObjectAtIndex:0];
}
- (void)addRunloopObserver {
    // 拿到当前runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    // 定义上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    // 定义一个观察者
    static CFRunLoopObserverRef defaultModeObserver;
    // 创建一个观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &TaskCallBack,  &context);
    // 添加观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopCommonModes);
    // C语言有create就要有release
    CFRelease(defaultModeObserver);
    
}
- (void)addTask:(RunloopBlock)task {
    [self.tasks addObject:task];
    if (self.tasks.count > self.maxQueueLength) {
        // 干掉最开始的任务
        [self.tasks removeObjectAtIndex:0];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (NSInteger i = 1; i < 5; i++) {
        [[cell.contentView viewWithTag:i] removeFromSuperview];
    }
    // 添加文字
    [self addLabel:cell atIndexPath:indexPath];
    // 添加图片
    [self addTask:^{
        [ViewController addImage1:cell];
    }];
    [self addTask:^{
        [ViewController addImage2:cell];
    }];
    [self addTask:^{
        [ViewController addImage3:cell];
    }];
    return cell;
    
}
- (void)addLabel:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, width - 20, 30)];
    label.text = [NSString stringWithFormat:@"我是一个小label - %ld",(long)indexPath.row];
    label.backgroundColor = [UIColor systemPinkColor];
    label.tag = 1;
    [cell.contentView addSubview:label];
}
+ (void)addImage1:(UITableViewCell*)cell {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 80, 50)];
    imageView.tag = 2;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:imageView];
    } completion:nil];
    
}
+ (void)addImage2:(UITableViewCell*)cell {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 50, 80, 50)];
    imageView.tag = 3;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:imageView];
    } completion:nil];
}
+ (void)addImage3:(UITableViewCell*)cell {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 50, 80, 50)];
    imageView.tag = 4;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:imageView];
    } completion:nil];
}
@end
