grant all privileges on  *.* to 'user'@'localhost' WITH GRANT OPTION;
SHOW GRANTS FOR 'user'@'localhost';
REVOKE all ON *.* FROM 'user'@'localhost';

ALTER USER 'user_name'@'localhost' identified with mysql_native_password by 'user_password';
FLUSH privileges;

show variables where variable_name like 'character_set_%' or variable_name like 'collation%';
ALTER DATABASE DATABASE_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE TABLE_NAME CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 
