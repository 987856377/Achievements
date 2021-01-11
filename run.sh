#!/bin/bash
#fonts color
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

zk="apache-zookeeper-3.5.8-bin.tar.gz"
jdk="jdk1.8.0_271.tar.gz"

server="192.168.220.128"
username="root"
location="/usr/dev/"
path="/usr"

base_path=$(basename $location)

#read -p "input the server IP to copy from:" server
#read -p "input the server username to login:" username
#read -p "input the server resource location copy:" location
#read -p "input the path to deploy:" path

validInput


active=$(systemctl status firewalld | grep -c active)
[[ $active -ge 1 ]] && yellow "firewall is active"

function validInput
{
	if [ -n $server ] ; then
		green "your input server is: $server"
	else
		red "your input server is not supported!"
		exit 1
	fi
	if [ -n $username ] ; then
		green "your input username is: $username"
	else
		red "your input username is not supported!" 
		exit 1
	fi
	if [ -n $location ] ; then
		green "your input location is: $location"
	else
		red "your input location is not supported!" 
		exit 1
	fi
	if [ -n $path ] ; then
		green "your input path is: $path"
	else
		red "your input path is not supported!"
		exit 1
	fi
}


function configJDK
{
	green "unzip $path/$base_path/$jdk start..."
	tar -zxf $path/$base_path/$jdk  -C $path/$base_path
	green "unzip $path/$base_path/$jdk success!"

	green "config PATH start..."
	cat >> /etc/profile <<- EOF
		export JAVA_HOME=$path/$base_path/$(basename $jdk .tar.gz)
		export PATH=\$PATH:\$JAVA_HOME/bin
	EOF
	source /etc/profile
	green "config PATH success!"
}

function tarZookeeper()
{
	green "unzip $path/$base_path/$zk start..."
	tar -zxf $path/$base_path/$zk -C $path/$base_path
	cp $path/$base_path/$(basename $zk .tar.gz)/conf/zoo_sample.cfg $path/$base_path/$(basename $zk .tar.gz)/conf/zoo.cfg
	green "unzip $path/$base_path/$zk success!"
}

function startZookeeper()
{
	if [ ! -e $path/$base_path/$(basename $zk .tar.gz)/bin/zkServer.sh ] ; then
		red "$path/$base_path/$(basename $zk .tar.gz)/bin/zkServer.sh is not exist!"
		exit 1
	fi

	sh $path/$base_path/$(basename $zk .tar.gz)/bin/zkServer.sh start
	zkActive=$(ps -ef | grep -c zookeeper)
	if [ $zkActive -gt 1 ] ; then
		green "zookeeper started success!"
	else
		red "zookeeper started failure!"
	fi
}

function deployAndStartServices()
{

	scp -r $username@$server:$location $path

	if [ -e $path/$base_path/$jdk ] ; then
		green  "$path/$base_path/$jdk download success!"
	else
		red "$path/$base_path/$jdk is not supported!"
	fi
	if [ -e $path/$base_path/$zk ] ; then
		green "$path/$base_path/$zk download success!"
	else
		red "$path/$base_path/$zk is not supported!"
	fi
	
	configJDK

	tarZookeeper
	startZookeeper
}

function startServices()
{
	startZookeeper
}

yellow "###########################################"
yellow "# 	1.一键安装并启动 		  #"
yellow "# 	2.一键启动		          #"
yellow "# 	0.退出				  #"
yellow "###########################################"

read -p "input the type you want to operate: " type
case $type in
	"0")
		exit 1
	;;
	"1")
		deployAndStartServices
	;;
	"2")
		startServices
	;;
	*)
		yellow "your commond is not supported!"
		exit 1
	;;
esac


