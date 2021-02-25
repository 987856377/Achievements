-- 分配权限
grant all privileges on  *.* to 'user'@'localhost' WITH GRANT OPTION;
SHOW GRANTS FOR 'user'@'localhost';
REVOKE all ON *.* FROM 'user'@'localhost';

-- 修改密码
ALTER USER 'user_name'@'localhost' identified with mysql_native_password by 'user_password';
FLUSH privileges;

-- 设置字符集
show variables where variable_name like 'character_set_%' or variable_name like 'collation%';
ALTER DATABASE DATABASE_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE TABLE_NAME CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 

-- 查看当前数据库连接
SHOW PROCESSLIST;
-- 查看最大连接数
SHOW VARIABLES LIKE '%max_connections%';
-- 修改最大连接数
SET GLOBAL max_connections = 200;


-- 当前状态展示
SHOW STATUS;
-- 当前已连接上的线程数
SHOW STATUS LIKE 'Threads_connected';
-- 同时使用的连接的最大数目
SHOW STATUS LIKE 'Max_used_connections'; 


-- 慢查询日志
SHOW VARIABLES LIKE 'slow_query%';
SHOW VARIABLES LIKE 'long_query_time';
-- 设置慢查询日志
SET GLOBAL slow_query_log='ON'; 
-- 设置查询超过1秒就记录
SET GLOBAL long_query_time=1;
-- 设置慢查询日志存放的位置
SET GLOBAL slow_query_log_file='/usr/local/mysql/data/slow.log'; -- linux
SET GLOBAL slow_query_log_file='D:\mysql\data\slow.log';         -- windows


-- 是否开启binlog日志
SHOW VARIABLES LIKE '%log_bin%';


-- 查看当前正在执行的SQL语句
SELECT * FROM information_schema.processlist WHERE STATE = 'Sending data';
-- 生成kill慢进程
SELECT CONCAT('KILL ',id,';') FROM information_schema.processlist p INNER JOIN information_schema.INNODB_TRX x ON p.id = x.trx_mysql_thread_id WHERE db='test';

-- 自动关闭处于sleep状态的连接
SHOW GLOBAL VARIABLES LIKE 'wait_timeout';
SHOW GLOBAL VARIABLES LIKE 'interactive_timeout';
set global wait_timeout=30;
SET GLOBAL interactive_timeout=30;
