//
//  AppDelegate.m
//  Performance
//
//  Created by cyd on 2021/4/15.
//

#import "AppDelegate.h"
#import "QYFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    QYFPSLabel *fpsLabel = [[QYFPSLabel alloc] initWithFrame:CGRectMake(100, 100, 60, 40)];
    [self.window.rootViewController.view addSubview:fpsLabel];
    return YES;
}



@end
