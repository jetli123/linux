问题： online 服务器总是空间不够，
最终是重启进程释放文件句柄解决问题。

通过指令：lsof | grep deleted 指令，查看当前系统句柄未释放情况
通过结果可以发现，当前系统存在大量文件已经被删除（deleted），可是文件句柄并没有被释放的情况。

问题已经有答案了，因为系统中存在大量文件句柄没有释放，导致当前占用的磁盘空间无法释放。文件句柄释放不掉的根本原因，是因为当前有线程对句柄进行引用。

通过查询发现，有两种解决方案： 

1. 将当前线程进行重启，关闭线程，从而让句柄释放，释放空间 

2. 找到指定的文件句柄，将当前文件句柄的大小设置为空

根据当前的业务情况，需要对外提供实时服务，所以频繁重启不适合当前业务场景，那么只能选择将文件句柄内容置空。
文件句柄内容置空，文件的内容大小被置空，释放了磁盘空间，但是文件句柄并没有释放，可能导致【Too Many File is Open】 错误。

通过losf 获取当前文件的 PID 和 FD 两个参数
置空当前的文件内容：
echo > /proc/PID/fd/FD

lsof  filename 显示打开指定文件的所有进程

lsof -a 表示两个参数都必须满足时才显示结果

lsof -c string   显示COMMAND列中包含指定字符的进程所有打开的文件

lsof -u username  显示所属user进程打开的文件

lsof -g gid 显示归属gid的进程情况
lsof +d /DIR/ 显示目录下被进程打开的文件

lsof +D /DIR/ 同上，但是会搜索目录下的所有目录，时间相对较长
lsof -d FD 显示指定文件描述符的进程

lsof -n 不将IP转换为hostname，缺省是不加上-n参数

lsof -i 用以显示符合条件的进程情况

lsof -i[46] [protocol][@hostname|hostaddr][:service|port]
            
46 --> IPv4 or IPv6
            
protocol --> TCP or UDP
            
hostname --> Internet host name
            
hostaddr --> IPv4地址
            
service --> /etc/service中的 service name (可以不只一个)
            
port --> 端口号 (可以不只一个)
