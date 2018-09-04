#使用ssh反向代理，用有公网IP的服务器访问内网服务器。

#工具：
#内网服务器，安装autossh
#拥有公网ip的服务器

#1.在公网服务器的/etc/ssh/sshd_config文件中添加条目：
GatewayPorts yes
#以开启转接访问（不知道是否需要）
#重启ssh服务：
service sshd restart
#可能需要sudo权限

#2.在内网服务器上安装autossh，并设置密钥自动登陆：
sudo apt install autossh
ssh-keygen -t rsa
ssh-copy-id -i $HOME/.ssh/id_rsa name1@ip1 #name1是服务器用户名，ip1是服务器公网ip
#已可自动登陆

#3.在内网服务器使用autossh自动连接外网服务器：
autossh -M 8100 -fCNR 8101:localhost:22 name1@ip1
#第一个端口是连接服务器用，第二个是autossh保持连接需要的

#4.通过外网服务器访问内网：
#查看当前监听的端口：
netstat -tnl
#找到autossh命令中使用的端口，及其对应ip：ip2
ssh name2@ip2 -p port
#其中，name2为内网服务器登录名，ip2为反向代理指定的端口

#连接已成功