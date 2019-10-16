#WINDOWS命令行关闭本地占用的端口

查找对应的端口占用的进程: netstat -ano | findstr "8088" 找到占用8080端口对应的程序的PID号 

![1571228544043](C:\Users\daier\AppData\Roaming\Typora\typora-user-images\1571228544043.png)

根据PID号找到对应的程序：tasklist | findstr "8088" ，找到对应的程序名 

![1571228632609](C:\Users\daier\AppData\Roaming\Typora\typora-user-images\1571228632609.png)

结束该进程：taskkill /f /t /im javaw.exe；或者taskkill /pid PID号 /F

![1571228595540](C:\Users\daier\AppData\Roaming\Typora\typora-user-images\1571228595540.png)

