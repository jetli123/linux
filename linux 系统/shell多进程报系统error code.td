在 编写 shell 多进程脚本，导出多个表到库中，执行的时候 报错：
mysqldump: Got errno 32 on write

这个是系统的 error code ，通过 perror 指令查看说明
[root@kvm-server ansible]# perror 32
OS error code  32:  Broken pipe  # 管道破裂

原因：
1.你的磁盘空间满了
2.gzip超过了您的主机的任何最大CPU时间/使用量。

最终确认是 虚拟机中，多进程已近超出了，虚拟机的最大CPU个数
