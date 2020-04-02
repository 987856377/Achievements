1. Idea 安装 Java Bytecode Decomplier 插件
2. 新建文件夹decompiler, 将待反编译的jar包放进去
3. 在新建的文件夹中再创建文件夹dist,放置反编译出来的jar包
4. 执行命令 java -cp "D:\Program Files\IntelliJ IDEA 2019.2\plugins\java-decompiler\lib\java-decompiler.jar" org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler -dgs=true development-0.0.1-SNAPSHOT.jar
dist
5. 解压dist文件夹下的jar包可得反编译后的java文件
