MySQL [(none)]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: 
                  Master_Host: 10.0.4.138
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: log-bin.000008
          Read_Master_Log_Pos: 318
               Relay_Log_File: log-relay.000001
                Relay_Log_Pos: 4
        Relay_Master_Log_File: log-bin.000008
             Slave_IO_Running: No
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 318
              Relay_Log_Space: 151
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 1593
                Last_IO_Error: Fatal error: The slave I/O thread stops because master and slave have equal MySQL server ids; these ids must be different for replication to work (or the --replicate-same-server-id option must be used on slave but this does not always make sense; please check the manual before using it).
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 
             Master_Info_File: /home/elex/mysql/data/master.info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for the slave I/O thread to update it
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 190409 19:19:10
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 47a39374-5ab3-11e9-b24c-000c29c06f5f:1-3
                Auto_Position: 0
                Auto_Position: 0

				
				mysql 5.7的复制引入了uuid的概念，各个复制结构中的server_uuid得保证不一样，但是查看到直接copy  data文件夹后server_uuid是否相同的，
				show variables like '%server_uuid%';
				上面报错说的是replication架构中需要保证每个mysql实例UUID(UUID保存在datadir目录下的auto.cnf文件中)唯一，
				就跟server_id一样需要保证主从架构中所有mysql实例server_id唯一。
