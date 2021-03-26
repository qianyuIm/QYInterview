//
//  ViewController.m
//  Block
//
//  Created by cyd on 2021/3/25.
//

#import "ViewController.h"

@interface Persion : NSObject
@property (nonatomic, copy) NSString *name;

@end

@implementation Persion



@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) Persion *persion;
@property (nonatomic, copy) NSString *name;

@end

@implementation ViewController
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@{@"Block类型": @"MRCController"},
                        @{@"循环引用": @"CycleController"}];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    int num = 10;
    self.name = @"123";
    _persion = [[Persion alloc] init];
    void (^MyBlock)(void) = ^{
        NSLog(@"%d",num);
        NSLog(@"%@",self.name);
        NSLog(@"%@",_persion.name);
    };
    num = 456;
    self.name = @"456";
    self.persion.name = @"xiaohong";
    MyBlock();
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataSource[indexPath.row];
    NSString *title = dict.allKeys.firstObject;
    NSString *className = dict.allValues.firstObject;
    Class cla = NSClassFromString(className);
    UIViewController *target = [[cla alloc] init];
    target.navigationItem.title = title;
    [self.navigationController pushViewController:target animated:YES];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.row];
    NSString *title = dict.allKeys.firstObject;
    NSString *className = dict.allValues.firstObject;

    cell.textLabel.text = [NSString stringWithFormat:@"%@ ----> %@",title, className];
    return  cell;
}

@end
