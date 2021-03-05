//
//  ViewController.m
//  HTTPS
//
//  Created by cyd on 2021/3/5.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 自制证书单向验证，只需要 ca-cert.cer
// HTTPS默认是单向验证，客户端不需要证书，但是如果自设的证书的话必须要在客户端加上一份
- (IBAction)customClick:(UIButton *)sender {
    //服务端自签名证书代码
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://127.0.0.1:3000"]];
    //AFSSLPinningModeCertificate表示使用自签名证书
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //为了测试方便不验证域名，若要验证域名，则请求时的域名要和创建证书（创建证书的脚本执行时可指定域名）时的域名一致
    policy.validatesDomainName = NO;
    //自签名服务器证书需要设置allowInvalidCertificates为YES
    policy.allowInvalidCertificates = YES;
    //指定本地证书路径
    policy.pinnedCertificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"https://127.0.0.1:3000/" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了 response = [%@]", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了 error %@", error);
    }];
}
// 自制证书双向验证，只需要 ca-cert.cer和client-cert.p12
- (IBAction)customTwoClick:(UIButton *)sender {
    //服务端自签名证书代码
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://127.0.0.1:3000"]];
    //AFSSLPinningModeCertificate表示使用自签名证书
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //为了测试方便不验证域名，若要验证域名，则请求时的域名要和创建证书（创建证书的脚本执行时可指定域名）时的域名一致
    policy.validatesDomainName = NO;
    //自签名服务器证书需要设置allowInvalidCertificates为YES
    policy.allowInvalidCertificates = YES;
    //指定本地证书路径
    policy.pinnedCertificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    manager.securityPolicy = policy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(manager) weakManager = manager;

    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing *_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        NSLog(@"authenticationMethod=%@",challenge.protectionSpace.authenticationMethod);
        //判断服务器要求客户端的接收认证挑战方式，如果是NSURLAuthenticationMethodServerTrust则表示去检验服务端证书是否合法，NSURLAuthenticationMethodClientCertificate则表示需要将客户端证书发送到服务端进行检验
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            // 基于客户端的安全策略来决定是否信任该服务器，不信任的话，也就没必要响应挑战
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                // 创建挑战证书（注：挑战方式为UseCredential和PerformDefaultHandling都需要新建挑战证书）
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                // 确定挑战的方式
                if (credential) {
                    //证书挑战  设计policy,none，则跑到这里
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else { //只有双向认证才会走这里
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client-cert"ofType:@"p12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
            {
                NSLog(@"client.p12:not exist");
            }
            else
            {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    [manager GET:@"https://127.0.0.1:3000/" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功了 response = [%@]", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了 error %@", error);
    }];
}

- (IBAction)baiduClick:(UIButton *)sender {
}

//读取p12文件中的密码
- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    // 密码
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@""
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
@end
