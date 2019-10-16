#WINDOWS命令行关闭本地占用的端口
查找对应的端口占用的进程: netstat -ano | findstr "PID号" 找到占用8080端口对应的程序的PID号
根据PID号找到对应的程序：tasklist | findstr "PID号"    ，找到对应的程序名
结束该进程：taskkill /f /t /im javaw.exe；或者taskkill /pid PID号 /F
