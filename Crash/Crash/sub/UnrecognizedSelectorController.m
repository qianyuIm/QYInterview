//
//  UnrecognizedSelectorController.m
//  Crash
//
//  Created by cyd on 2021/3/30.
//

#import "UnrecognizedSelectorController.h"

@interface UnrecognizedSelectorController ()
- (void)notImplementionFunc;
@end

@implementation UnrecognizedSelectorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"unrecognized selector sent to instance xxx'");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self notImplementionFunc];
}


@end
