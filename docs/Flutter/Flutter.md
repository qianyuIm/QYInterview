# Flutter

[官方示例](https://github.com/flutter/samples)

[非官方学习教程](https://book.flutterchina.club/chapter1/dart.html#_1-4-1-%E5%8F%98%E9%87%8F%E5%A3%B0%E6%98%8E)

[官方教程](https://flutter.cn/docs/cookbook)
## 1.安装Flutter

1.安装镜像: 由于在国内访问Flutter有时可能会受到限制，Flutter官方为中国开发者搭建了临时镜像，大家可以将如下环境变量加入到用户环境变量中(打开终端执行下面命令)：
	
	> export PUB_HOSTED_URL=https://pub.flutter-io.cn	

	> export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

	
2.获取Flutter SDK

这里我直接使用git clone命令(YOURPATH为你FlutterSDK安装目录 替换成你想要安装的路径):

```
1. cd YOURPATH
2. git clone -b dev https://github.com/flutter/flutter.git

```

添加flutter相关工具到path中 **pwd** 为你flutter安装路径：

	 export PATH=`pwd`/flutter/bin:$PATH
	

运行Flutter doctor命令查看是否需要安装其它依赖项来完成安装，这一步需要的时间可能会特别长要有耐心、要有耐心、要有耐心，重要的事说三遍。

	 flutter doctor
	
3.更新环境变量

cd 到当前安装flutter的安装目录eg: 我的安装到了 FlutterSDK目录下为

>  cd /Users/lipengyuan/Documents/FlutterSDK

>  编辑可以直接打开这个文件 .bash_profile


> 写入 export PATH=/Users/lipengyuan/Documents/FlutterSDK/flutter/bin:$PATH

> source ~/.bash_profile

## 打开模拟器
> open -a Simulator

## 2.配置编辑器
1. [VS Code配置安装1.20.1或更高版本.](https://flutterchina.club/get-started/editor/#vscode)
	* 启动 VS Code
	* 调用View -> Command Palette
	* 输入 ‘install’, 然后选择 Extensions: Install Extension action
	* 在搜索框输入 flutter , 在搜索结果列表中选择 ‘Flutter’, 然后点击 Install
	* 选择 ‘OK’ 重新启动 VS Code
	* 运行 doctor 配置vscode

## Flutter 查看
稳定性排序：master < dev < beta < stable 。
> flutter channel  查看当前Flutte渠道

>  flutter channel  stable

> flutter doctor -v 查看具体版本信息

## 3.创建你的第一个Flutter项目：

下载下来的flutter项目如果没有 .ios 等文件
> flutter pub get 

创建完成之后，需要手动在ios 工程中选择对应的描述文件。

命令行: 

	flutter create startup_namer(名称必须为小写)
	cd startup_namer
	flutter run


## swift与Flutter混编
> MixedTest 文件夹下分别创建原生和flutter程序

> FlutterIos 原生程序

> flutter_module flutter程序:  flutter create --template module my_flutter


![Flutter_Directory](images/Flutter_Directory.png)

Podfile配置如下:

```
platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'


# Flutter
flutter_application_path = '../flutter_module/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'FlutterIos' do
  pod 'SnapKit'
  # 引入flutter
  install_all_flutter_pods(flutter_application_path)
  
  # Flutter相关集成是不支持bitcode的，
  #所以需要将相关产物的bitcode功能关闭。
  #如果你的现有工程中仓库众多，有的仓库是必须bitcode的，
  #这样的话就需要每次pod install之后再在工程配置中手动设置回来，
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name =="App" || target.name =="Flutter"
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] ='NO'
      end
    end
  end
end
  
end

```

原生启动时候注册:

```
self.flutterEngine = FlutterEngine(name: "io.flutter", project: nil)
self.flutterEngine?.run(withEntrypoint: nil)

```
