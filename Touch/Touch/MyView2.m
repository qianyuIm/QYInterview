//
//  MyView2.m
//  Touch
//
//  Created by cyd on 2022/2/17.
//

#import "MyView2.h"

@implementation MyView2
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL boo = [super pointInside:point withEvent:event];
    return boo;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
    NSLog(@"触摸 ------ MyView2");
}


@end