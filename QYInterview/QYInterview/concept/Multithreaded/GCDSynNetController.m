//
//  GCDSynNetController.m
//  QYInterview
//
//  Created by cyd on 2022/2/23.
//

#import "GCDSynNetController.h"
#import <AFNetworking.h>
@interface GCDSynNetController ()

@end

@implementation GCDSynNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)syncNet:(id)sender {
    NSLog(@"开始同步请求");
    [self syncNetwork:^(NSString *string) {
        NSLog(@"%@",string);
    }];
    NSLog(@"开始同步请求完成");
}

- (IBAction)asyncNet:(id)sender {
    NSLog(@"开始异步请求");
    [self asyncNetwork:^(NSString *string) {
        NSLog(@"%@",string);
    }];
    NSLog(@"开始异步请求完成");
}
// 模拟异步请求
- (void)asyncNetwork:(void(^)(NSString *string))callBack {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpeg", nil];
    NSString *url = @"http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg";
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(@"图片下载完成");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(@"图片下载失败");
    }];
        
}

- (void)syncNetwork:(void(^)(NSString *string))callBack  {
    NSString *url = @"http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *urlSessionDataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
        dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSThread currentThread]);
            callBack(@"请求完成");
            dispatch_semaphore_signal(semaphore1);
        });
        dispatch_semaphore_signal(semaphore);

        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);

//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }];
    [urlSessionDataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"-------%@",[NSThread currentThread]);
    
}
@end
