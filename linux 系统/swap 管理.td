限制 系统有限使用 swap 交换分区

echo 0 >/proc/sys/vm/swappiness 
sysctl -w vm.swappiness=0 

永久关闭swap
swapoff -a
cat /etc/fstab 
注释swap 分区设置
重启系统

开启 swap:
swapon -a
查询swap 分区
swapon -s
