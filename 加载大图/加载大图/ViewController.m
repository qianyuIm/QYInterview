//
//  ViewController.m
//  加载大图
//
//  Created by cyd on 2022/2/16.
//

#import "ViewController.h"

static NSString *Identifier = @"123";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
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
    [self addImage1:cell];
    [self addImage2:cell];
    [self addImage3:cell];
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
- (void)addImage1:(UITableViewCell*)cell {
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
- (void)addImage2:(UITableViewCell*)cell {
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
- (void)addImage3:(UITableViewCell*)cell {
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
