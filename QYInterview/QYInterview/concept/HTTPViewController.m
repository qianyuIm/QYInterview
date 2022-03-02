//
//  HTTPViewController.m
//  QYInterview
//
//  Created by cyd on 2022/3/2.
//

#import "HTTPViewController.h"

@interface HTTPViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation HTTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"使用抓包工具查看，返回200还是304");
}
static NSString *cacheUrl = @"https://img1.baidu.com/it/u=2967374291,793573808&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=280";
// 使用缓存
- (IBAction)useCache:(id)sender {
    NSURL *url = [NSURL URLWithString:cacheUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
//            self.lastModified = httpResponse.allHeaderFields[@"Last-Modified"];
//            self.Etag = httpResponse.allHeaderFields[@"Etag"];
        NSCachedURLResponse * cacheRespose = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
            if (httpResponse.statusCode == 304){
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = [UIImage imageWithData:cacheRespose.data];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = [UIImage imageWithData:data];
                });
            }
            
        }];
        [task resume];
}
- (IBAction)noCache:(id)sender {
    
}


@end
