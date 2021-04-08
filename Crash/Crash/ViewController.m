//
//  ViewController.m
//  Crash
//
//  Created by cyd on 2021/3/30.
//

#import "ViewController.h"

@interface QYItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *className;
+ (instancetype)itemWithTitle:(NSString*)title
                    className:(NSString*)className;
@end

@implementation QYItem
+ (instancetype)itemWithTitle:(NSString*)title
                    className:(NSString*)className{
    QYItem *item = [[QYItem alloc] init];
    item.title = title;
    item.className = className;
    return item;
}

@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ViewController
- (NSArray *)dataSource {
    if (!_dataSource) {
        QYItem *item1 = [QYItem itemWithTitle:@"未找到方法实现" className:@"UnrecognizedSelectorController"];
        QYItem *item2 = [QYItem itemWithTitle:@"KVC造成的Crash" className:@"KVCCrashController"];
        QYItem *item3 = [QYItem itemWithTitle:@"EXC_BAD_ACCESS" className:@"BadAccessController"];
        QYItem *item4 = [QYItem itemWithTitle:@"KVO造成的Crash" className:@"KVOCrashController"];
        // Watch Dog超时造成的crash
        _dataSource = @[item1,
                        item2,
                        item3,
                        item4];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QYItem *item = self.dataSource[indexPath.row];
    Class controller = NSClassFromString(item.className);
    UIViewController *subController = [[controller alloc] init];
    subController.navigationItem.title = item.title;
    [self.navigationController pushViewController:subController animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    QYItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.className;
    return  cell;
}




@end
