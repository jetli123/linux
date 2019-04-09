rpm -qpi包名#<==查看rpm包详细信息
rpm -qpl包名#<==查看rpm包里面的内容
rpm -qpR包名#<==查看rpm包的依赖
rpm -qp --scripts 包名#<==查看rpm包带的执行脚本，执行脚本不是以文件形式存在
-a#<==all，所有-q#<==query，查询
-p#<==package,包-i#<==info，信息
-l#<==list，列表-R#<==requires，依赖
-f#<==查询文件属于哪个软件包--scripts#<==显示脚本


查看rpm包详细信息

[root@m01 /server/scripts]# rpm -qpi nginx-1.6.3-1.x86_64.rpm
Name        : nginx                        Relocations: / 
Version     : 1.6.3                             Vendor: root@m01
Release     : 1                             Build Date: 2017年05月30日 星期二 13时40分25秒
Install Date: (not installed)               Build Host: m01
Group       : default                       Source RPM: nginx-1.6.3-1.src.rpm
Size        : 5252902                          License: unknown
Signature   : (none)
Packager    : <root@m01>
URL         : http://example.com/no-uri-given
Summary     : no description given
Description :
no description given


查看rpm包里面的内容

[root@m01 /server/scripts]# rpm -qpl nginx-1.6.3-1.x86_64.rpm 
/application/nginx-1.6.3/conf/fastcgi.conf
/application/nginx-1.6.3/conf/fastcgi.conf.default
/application/nginx-1.6.3/conf/fastcgi_params
/application/nginx-1.6.3/conf/fastcgi_params.default
/application/nginx-1.6.3/conf/koi-utf
/application/nginx-1.6.3/conf/koi-win
/application/nginx-1.6.3/conf/mime.types
/application/nginx-1.6.3/conf/mime.types.default
/application/nginx-1.6.3/conf/nginx.conf
/application/nginx-1.6.3/conf/nginx.conf.default
/application/nginx-1.6.3/conf/scgi_params
/application/nginx-1.6.3/conf/scgi_params.default
/application/nginx-1.6.3/conf/uwsgi_params
/application/nginx-1.6.3/conf/uwsgi_params.default
/application/nginx-1.6.3/conf/win-utf
/application/nginx-1.6.3/html/50x.html
/application/nginx-1.6.3/html/index.html
/application/nginx-1.6.3/logs
/application/nginx-1.6.3/sbin/nginx


查看rpm包的依赖

[root@m01 /server/scripts]# rpm -qpR nginx-1.6.3-1.x86_64.rpm 
pcre  
pcre-devel  
openssl  
openssl-devel  
/bin/sh  
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rpmlib(CompressedFileNames) <= 3.0.4-1


查看rpm包带的执行脚本

[root@m01 /server/scripts]# rpm -qp --scripts nginx-1.6.3-1.x86_64.rpm 
postinstall scriptlet (using /bin/sh):
#!/bin/bash
useradd nginx -u 888 -M -s /sbin/nologin
ln -s /application/nginx-1.6.3/ /application/nginx
