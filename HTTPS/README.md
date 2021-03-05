[详解AFNetworking的HTTPS模块](http://awstar.cn/2018/11/25/详解AFNetworking的HTTPS模块/#4-4-服务端使用CA机构颁发的正式证书)
## 服务端工程使用方法：
1. 安装`nodejs`，[http://nodejs.cn/download/](http://nodejs.cn/download/)
2. 在终端内，使用`cd`命令进入服务端工程：`cd xx/Server/testhttps`，然后执行命令：`node app.js`
 
## 证书脚本使用方法：
1. 在终端内，使用`cd`命令进入`Sh`目录: `cd xx/Sh`
2. 执行命令：`chmod +x create.sh`
3. 执行命令：`./create.sh` 回车
4. 也可以带参数，执行 `./create.sh -h` 回车，参考输出内容
 
> ./create.sh -h 打印用法

> ./create.sh -c 会清空生成的所有文件

> ./create.sh 直接回车，会使用默认参数生成证书

> ./create.sh + 用法中所述选项 会使用自定义的参数生成证书

* .der格式证书 <=> .cer  修改后缀即可
* .pem格式证书
* .p12格式证书
* .pem格式私钥
* .csr格式证书申请文件