当开启mysql数据库主从时，会产生大量如mysql-bin.00000* log的文件，这会大量耗费您的硬盘空间。
mysql-bin.000001
mysql-bin.000002
mysql-bin.000003
mysql-bin.000004
mysql-bin.000005
…
有三种解决方法：1.关闭mysql主从，关闭binlog；2.开启mysql主从，设置expire_logs_days；3.手动清除binlog文件，> PURGE MASTER LOGS TO ‘MySQL-bin.010’;

实现：
1.关闭mysql主从，关闭binlog

# vim /etc/my.cnf  //注释掉log-bin,binlog_format
# Replication Master Server (default)
# binary logging is required for replication
# log-bin=mysql-bin
# binary logging format - mixed recommended
# binlog_format=mixed
然后重启数据库

2.重启mysql,开启mysql主从，设置expire_logs_days

# vim /etc/my.cnf  //修改expire_logs_days,x是自动删除的天数，一般将x设置为短点，如10
expire_logs_days = x  //二进制日志自动删除的天数。默认值为0,表示“没有自动删除”
此方法需要重启mysql，附录有关于expire_logs_days的英文说明

当然也可以不重启mysql,开启mysql主从，直接在mysql里设置expire_logs_days

&gt; show binary logs;
&gt; show variables like '%log%';
&gt; set global expire_logs_days = 10;
3.手动清除binlog文件

# /usr/local/mysql/bin/mysql -u root -p
&gt; PURGE MASTER LOGS BEFORE DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY);   //删除10天前的MySQL binlog日志,附录2有关于PURGE MASTER LOGS手动删除用法及示例
&gt; show master logs;
也可以重置master，删除所有binlog文件：

# /usr/local/mysql/bin/mysql -u root -p
&gt; reset master;  //附录3有清除binlog时，对从mysql的影响说明
附录：
1.expire_logs_days英文说明
Where X is the number of days you’d like to keep them around. I would recommend 10, but this depends on how busy your MySQL server is and how fast these log files grow. Just make sure it is longer than the slowest slave takes to replicate the data from your master.
Just a side note: You know that you should do this anyway, but make sure you back up your mysql database. The binary log can be used to recover the database in certain situations; so having a backup ensures that if your database server does crash, you will be able to recover the data.

2.PURGE MASTER LOGS手动删除用法及示例,MASTER和BINARY是同义词

&gt; PURGE {MASTER | BINARY} LOGS TO 'log_name'
&gt; PURGE {MASTER | BINARY} LOGS BEFORE 'date'
删除指定的日志或日期之前的日志索引中的所有二进制日志。这些日志也会从记录在日志索引文件中的清单中被删除MySQL BIN-LOG 日志，这样被给定的日志成为第一个。

实例：

&gt; PURGE MASTER LOGS TO 'MySQL-bin.010';  //清除MySQL-bin.010之前的日志，不包括MySQL-bin.010
&gt; PURGE MASTER LOGS BEFORE '2008-06-22 13:00:00';   //清除2008-06-22 13:00:00前binlog日志
&gt; PURGE MASTER LOGS BEFORE DATE_SUB( NOW( ), INTERVAL 3 DAY);  //清除3天前binlog日志BEFORE，变量的date自变量可以为'YYYY-MM-DD hh:mm:ss'格式。
3.清除binlog时，对从mysql的影响
如果您有一个活性的从属服务器，该服务器当前正在读取您正在试图删除的日志之一，则本语句不会起作用，而是会失败，并伴随一个错误。不过，如果从属服务器是休止的，并且您碰巧清理了其想要读取的日志之一，则从属服务器启动后不能复制。当从属服务器正在复制时，本语句可以安全运行。您不需要停止它们。

原文参考：
My MySQL Binary Log files are taking up all my disk space!
自动清理MySQL binlog日志与手动删除的设置
