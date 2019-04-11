 有一些时候 我们需要将iptables 的INPUT链写死，那么我们可以用iptables -P INPUT DROP来全部关掉input链路。

但是随之产生了一个很严重的问题，那么服务器本身发送的数据请求返回的数据同样被iptables拒之门外，一个通俗的解释就是外部数据无法访问本地服务，本地服务器也无法正常上网。

解决的办法如下：

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
