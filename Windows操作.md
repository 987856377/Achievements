#WINDOWS命令行关闭本地占用的端口

查找对应的端口占用的进程: netstat -ano | findstr "8088" 找到占用8080端口对应的程序的PID号 

根据PID号找到对应的程序：tasklist | findstr "8088" ，找到对应的程序名 

结束该进程：taskkill /f /t /im javaw.exe；或者taskkill /pid PID号 /F


# WINDOWS 终端改为 utf-8 字符集

打开注册表 计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor
新建 -> 字符串值 -> 数据名称 AutoRun -> 数值数据 chcp 65001 >nul 2>&1
