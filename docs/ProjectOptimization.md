# 项目优化
### 1.项目结构与应用包瘦身
1. 代码瘦身 推荐使用 **[LinkMao](https://github.com/huanxsd/LinkMap)**,可以获取到项目中各个文件的大小,以权衡是否有替换方案

	> 在Xcode 中开启编译选项 ```Write link Map File```选项为 YES
	
	> Xcode -> Project -> Build Settings ->  Write link Map File
	
	> 工程编译完成后，在编译目录里找到Link Map文件(.txt类型) 默认地址: ~/Library/Developer/Xcode/DerivedData/XXX-xxx/Build/Intermediates/XXX.build/Debug-iphoneos/XXX.build/
	
2.应用包瘦身:

* 首先找出项目中未使用的图片

	> 使用 **[LSUnusedResources](https://github.com/tinymind/LSUnusedResources)**

* 图片无损压缩
 
	>使用 **[ImageOptim](https://github.com/ImageOptim/ImageOptim)**

	
### 2.项目性能优化

	