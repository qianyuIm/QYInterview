# 项目优化

## app启动优化
1. pre-main阶段的优化: 

	> 针对main函数之前的启动时间，苹果内建了测量方法: Edit Scheme -> Run -> Arguments -> Environment Variables 点击+添加环境变量  DYLD_PRINT_STATISTICS 设为 1

	pre-main阶段主要包括: 
	1. dylib loading time(动态库加载耗时) 。
	2.  rebase/binding time(偏移修整/符号绑定耗时)。
	3.  ObjC setup time (OC类注册的耗时)，OC类越多，越耗时。
	4. initializer time（执行load和构造函数的耗时）
	
	优化方案:  减少非系统库的依赖，尽量使用静态库而不是动态库，额外动态库加载系统要求最好控制在6个以内, 使用appCode查找并删除无用的类。如果使用了Objective-C的 +load 方法，看看能否将其替换为 +initialize 方法.尽量不要在load方法中做耗时任务
2. main函数阶段优化:
	主要是值didFinishLaunching 方法到首页展示出来这一阶段，所以首页的页面可以考虑使用代码编写，不使用xib或者SB。
	

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

	
### 2.项目性能优化

	