# 项目优化

## app启动优化
1. pre-main阶段的优化: 

	> 针对main函数之前的启动时间，苹果内建了测量方法: Edit Scheme -> Run -> Arguments -> Environment Variables 点击+添加环境变量  DYLD_PRINT_STATISTICS 设为 1，需要详细信息的话添加 DYLD_PRINT_STATISTICS_DETAILS 设为 1

	pre-main阶段主要包括: 
	1. dylib loading time(动态库加载耗时) 。
	2.  rebase/binding time(偏移修整/符号绑定耗时)。
	3.  ObjC setup time (OC类注册的耗时)，OC类越多，越耗时。
	4. initializer time（执行load和构造函数的耗时）
	
	优化方案:  减少非系统库的依赖，尽量使用静态库而不是动态库，额外动态库加载系统要求最好控制在6个以内, 使用appCode查找并删除无用的类。如果使用了Objective-C的 +load 方法，看看能否将其替换为 +initialize 方法.尽量不要在load方法中做耗时任务
2. main函数阶段优化:

	main函数调用之后 主要是didFinishLaunchingWithOptions 方法中初始化必要的服务，显示首页内容等操作，这时我们可以: 1.	

### 1.项目结构与应用包瘦身
1. 代码瘦身 推荐使用 **[LinkMap](https://github.com/huanxsd/LinkMap)**,可以获取到项目中各个文件的大小,以权衡是否有替换方案

	> 在Xcode 中开启编译选项 ```Write link Map File```选项为 YES
	
	> Xcode -> Project -> Build Settings ->  Write link Map File
	
	> 工程编译完成后，在编译目录里找到Link Map文件(.txt类型) 默认地址: ~/Library/Developer/Xcode/DerivedData/XXX-xxx/Build/Intermediates/XXX.build/Debug-iphoneos/XXX.build/
	
2.应用包瘦身:

* 首先找出项目中未使用的图片

	> 使用 **[LSUnusedResources](https://github.com/tinymind/LSUnusedResources)**

* 图片无损压缩
 
	>使用 **[ImageOptim](https://github.com/ImageOptim/ImageOptim)**
	
### 2.二进制重排

[二进制重排](https://juejin.cn/post/6937261357339410462#heading-10)

添加 `order file`  -> `$(SRCROOT)/rdld.order`

OC工程： 
> OC的前端编译器是`Clang`，所以在`other c flags`处添加`-fsanitize-coverage=func,trace-pc-guard`

swift 工程： 
> Swift的前端编译器是`Swift`，所以在`other Swift Flags`处添加`-sanitize=undefined` 和 `-sanitize-coverage=func`

配置代码:

```
#import <dlfcn.h>
#import <libkern/OSAtomic.h>

//定义原子队列: 特点 1.先进后出 2.线程安全 3.只能保存结构体
static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

//定义符号结构体链表
typedef struct{
    void *pc;
    void *next;
} SymbolNode;

/*
 - start：起始位置
 - stop：并不是最后一个符号的地址，而是整个符号表的最后一个地址，最后一个符号的地址=stop-4（因为是从高地址往低地址读取的，且stop是一个无符号int类型，占4个字节）。stop存储的值是符号的
 */
void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;  // Guards should start from 1.
}
/*
 可以全面hook方法、函数、以及block调用，用于捕捉符号，是在多线程进行的，这个方法中只存储pc，以链表的形式
 
 - guard 是一个哨兵，告诉我们是第几个被调用的
 */
void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//  if (!*guard) return;  // Duplicate the guard check. //将load方法过滤掉了，所以需要注释掉
    
    //获取PC
    /*
     - PC 当前函数返回上一个调用的地址
     - 0 当前这个函数地址，即当前函数的返回地址
     - 1 当前函数调用者的地址，即上一个函数的返回地址
    */
  void *PC = __builtin_return_address(0);
    
    //创建结构体!
  SymbolNode * node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC, NULL};
    
    
    //加入队列
    //符号的访问不是通过下标访问，是通过链表的next指针，所以需要借用offsetof（结构体类型，下一个的地址即next）
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));
    
    Dl_info info;// 声明对象
    dladdr(PC, &info);// 读取PC地址，赋值给info
    
    /*
     dli_fname - 函数的路径
     dli_fname - 函数的地址
     dli_sname - 函数符号
     dli_saddr - 函数起始地址
     */
//    printf("fnam:%s \n fbase:%p \n sname:%s \n saddr:%p \n",
//           info.dli_fname,
//           info.dli_fname,
//           info.dli_sname,
//           info.dli_saddr);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
    while (true) {
        //offsetof 就是针对某个结构体找到某个属性相对这个结构体的偏移量
        SymbolNode * node = OSAtomicDequeue(&symboList, offsetof(SymbolNode, next));
        if (node == NULL) break;
        Dl_info info;
        dladdr(node->pc, &info);
         
        NSString * name = @(info.dli_sname);
        NSLog(@"%@",name);
        // 添加 _
        BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
         
        //去重
        if (![symbolNames containsObject:symbolName]) {
            [symbolNames addObject:symbolName];
        }
    }
 
    //取反
    NSArray * symbolAry = [[symbolNames reverseObjectEnumerator] allObjects];
    NSLog(@"%@",symbolAry);
     
    //将结果写入到文件
    NSString * funcString = [symbolAry componentsJoinedByString:@"\n"];
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"lb.order"];
    NSData * fileContents = [funcString dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
    if (result) {
        NSLog(@"%@",filePath);
    }else{
        NSLog(@"文件写入出错");
    }
}

```

	
### 3.项目性能优化

	