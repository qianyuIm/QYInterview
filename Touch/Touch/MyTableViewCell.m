//
//  MyTableViewCell.m
//  Touch
//
//  Created by 丁帅 on 2022/2/20.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}
- (IBAction)selectedSender:(UIButton *)sender {
    NSLog(@"选中按钮");
}


@end
