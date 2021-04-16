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

**1. CPU优化**

1. 尽量使用基本数据类型这种轻量级的类型，避免使用对象类型，比如使用int而不是NSNumber。	
2. 避免UIView属性的频繁调整或设置，频繁冗余的设置属性frame, bounds, transform会频繁的浪费CPU的计算能力,会导致额外的CPU开销。因为CPU需要先计算好UIView的这些属性, 然后才会交由GPU渲染。
**这里特别说一下 CALayer：CALayer 内部并没有属性，当调用属性方法时，它内部是通过运行时resolveInstanceMethod  为对象临时添加一个方法，并把对应属性值保存到内部的一个 Dictionary 里， 同时还会通知 delegate、创建动画等等，非常消耗资源。UIView 的关于显示相关的属性（比如 frame/bounds/transform）等实际上都是 CALayer 属性映射来的， 所以对 UIView 的这些属性进行调整时，消耗的资源要远大于一般的属性。对此你在应用中，应该尽量减少不必要的属性修改,可以手动添加在分类中添加属性测试**	。当视图层次调整时，UIView、CALayer 之间会出现很多方法调用与通知，所以在优化性能时，应该尽量避免调整视图层次、添加和移除视图

3. 视图无交互时尽量使用CALayer，比如使用CALayer代替UIView\UILabel\UIImageView。
	
4. 尽量提前计算好布局，一次性设置给UIView，避免多次设置。
		
* 复杂的页面推荐使用frame布局，尽量不要使用autolayout。
		autolayout会比frame布局消耗更多的CPU资源。
*  尽量把耗时的操作放到子线程。比如文本处理（包括尺寸计算和文本绘制）、
		图片处理（包括解码和绘制）。
		
		1. 尽量在子线程计算文本尺寸，比如boundingRect方法的调用，可以放到子线程。
		2. 尽量在子线程对图片进行解码（UIImage只有在显示的时候才会解码，
		而这个操作一般是在主线程，所以容易造成卡顿）
		3. 图片的size最好刚好和UIImageView的size一致。尽量避免图片尺寸伸缩。
		4. 如果确定子视图大小和位置是固定的，那么避免在cell的layoutSubViews中设置子视图的
		位置和大小。因为tableView滚动时候会调用cell的layoutSubView方法。
		cell的layoutSubViews方法中布局代码太多比较耗时。
		5. 使用多线程的话  控制线程的最大并发数量 线程间切换也是会消耗CPU的

**2. GPU优化**

1. 尽量减少视图数量和层次。
2. GPU能处理的最大文理尺寸是4096*4096，一旦超过这个尺寸，就会占用CPU资源进行处理。
3. 尽量避免离屏渲染,圆角等
	* 光栅化 layer.shouldRasterize = YES 会触发离屏渲染
	* 遮罩 layer.mask = xxx 也会触发离屏渲染
	* 圆角 同时设置了layer.masksToBounds = YES、layer.cornerRadius大于0会触发离屏渲染。只设置layer.masksToBounds = YES或者layer.cornerRadius大于0不会触发离屏渲染 （如果需要圆角，可以使用CoreGraphics绘制裁剪圆角或者让UI提供圆角图片）
	* 阴影 layer.shadowXXX 比如layer.shadowColor、layer.shadowOffset 都会触发离屏渲染,如果设置了layer.shadowPath就不会触发离屏渲染
	* 开启光栅化 shouldRasterize=true 
  


