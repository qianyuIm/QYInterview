# BugFix 集合

## 嵌入webView,原生导航条隐藏使用webView写的导航条,这个时候如果webView有输入框(输入框偏向webview底部)的情况下,键盘弹出，webView会自动跟随键盘的弹出而向上偏移，
* 因为webView向上偏移，导航条也会向上偏移的，不介意的话没有问题。
* 介意的话，只能原生监听键盘的弹出和隐藏，来修改webview的contentInset 和 contentSize,但是虽然这样写了可以暂时解决这个问题，但如果后续H5端，修改他们代码所使用的框架的话，可能还会导致问题重现，所以不建议web端控制导航条，可以使用原生导航去替代。
	
## WKWebView cookies 同步问题


1 初始化时候  注入js
	
```
WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:[self cookieString] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];

WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
WKUserContentController * userContentController = [[WKUserContentController alloc]init];
	
[userCC addUserScript: cookieScript];
configuration.userContentController = userContentController;

- (NSString *)cookieString {
    NSMutableString *script = [NSMutableString string];
    [script appendString:@"var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n"];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
            continue;
        }
        // 自定义
        NSString *string = [NSString stringWithFormat:@"%@=%@;domain=%@;path=%@",
                            cookie.name,
                            cookie.value,
                            cookie.domain,
                            cookie.path ?: @"/"];
        
        [script appendFormat:@"if (cookieNames.indexOf('%@') == -1) { document.cookie='%@'; };\n", cookie.name, string];
    }
    return script;
}
```
	
2 请求方式
	
```
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
request.allHTTPHeaderFields = dict;
[self.wkWebView loadRequest:request];
```
	
3  解决跨域问题，在代理中每次跳转之前拼接Cookies
	
```
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    [self wkWebViewWillStart:url];
    //为了解决跨域问题，每次跳转url时把cookies拼接上
    NSMutableURLRequest *request = (NSMutableURLRequest *)navigationAction.request;
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    request.allHTTPHeaderFields = dict;
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
```
