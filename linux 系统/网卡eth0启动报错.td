/etc/udev/rules.d/70-persistent-net.rules
可以删掉 有的 eth1那一行
将最后一行的 NAME改成  eth0 ,将 ATTR=(address)=="00:0c:29:c0:6f:5f" 网卡MAC 地址贴到 ifcfg-eth0 配置文件中，重启
