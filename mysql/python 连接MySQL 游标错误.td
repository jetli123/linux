[root@s316-dal9 ~]# ./migrate_zone_inventory.py --list
Traceback (most recent call last):
  File "./migrate_zone_inventory.py", line 217, in <module>
    Inventory()
  File "./migrate_zone_inventory.py", line 63, in __init__
    self.db_info()
  File "./migrate_zone_inventory.py", line 182, in db_info
    cursor.close()
  File "/usr/lib/python2.7/site-packages/mysql/connector/cursor.py", line 388, in close
    self._connection.handle_unread_result()
  File "/usr/lib/python2.7/site-packages/mysql/connector/connection.py", line 1063, in handle_unread_result
    raise errors.InternalError("Unread result found")
mysql.connector.errors.InternalError: Unread result found

官方：
For queries executed using a buffered cursor, row-fetching methods such as fetchone() return rows from the set of buffered rows. 
For nonbuffered cursors, rows are not fetched from the server until a row-fetching method is called. In this case, 
you must be sure to fetch all rows of the result set before executing any other statements on the same connection, 
or an InternalError (Unread result found) exception will be raised.


import mysql.connector

cnx = mysql.connector.connect()

# Only this particular cursor will buffer results
cursor = cnx.cursor(buffered=True)

# All cursors created from cnx2 will be buffered by default
cnx2 = mysql.connector.connect(buffered=True)
