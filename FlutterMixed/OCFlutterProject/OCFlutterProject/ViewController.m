//
//  ViewController.m
//  OCFlutterProject
//
//  Created by cyd on 2022/2/18.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <Flutter/Flutter.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)showFlutter:(UIButton *)sender {
    FlutterEngine *flutterEngine =
            ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController =
            [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}


@end
