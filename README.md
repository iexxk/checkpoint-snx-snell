需求，电脑想连2个check point vpn，但是网上客户端支持一个

因此另一个打算用snx加容器进行部署然后在用snell来代理到surge上面进行访问，因此需要制作一个snx加上snell的镜像。

采用snell的原因，比较简单，其他的strongSwan、ss都比较复杂。

编译源码件[iexxk/checkpoint-snx-snell](https://github.com/iexxk/checkpoint-snx-snell)

### 使用

```bash
#启动容器
docker run --name snx-vpn --cap-add=ALL -p 500:500 -v /lib/modules:/lib/modules -d exxk/checkpoint-snx-snell:latest
#进入容器
docker exec -it snx-vpn bash
#登录vpn，执行下面的命令会提示输入密码，然后提示是否接受，然后输入y
snx -s 服务svn的ip -u 用户名
#查看vpn路由地址
route
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.16.192.0   0.0.0.0         255.255.224.0   U     0      0        0 tunsnx
192.16.250.1   0.0.0.0         255.255.255.255 UH    0      0        0 tunsnx
U对应SRC-IP类型
UH对应IP-CIDR类型 255.255.224.0对应192.16.192.0/19    详细见：子网掩码计算
一个255对应8位，三个255就是3*8=24，最后一个不是2个8位+11100000（单个1）转换为十进制就是224
#停止容器
docker stop snx-vpn
#删除容器
docker rm snx-vpn
```

#### 自定义修改配置

修改配置可以修改容器内这个`/etc/snell/snell-server.conf`配置文件，可以修改psk密码(如果暴露在外一定要修改密码)和端口

#### 客户端配置

##### 配置代理

进入`surge-->代理-->策略-->规则判断-->新建一个代理`

配置

* 服务器地址：容器的宿主机地址（本机就127.0.0.1）
* 端口：默认500
* PSK：默认2iPRYDZyOVfjRwt9
* 混淆：TLS

然后根据那些地址自己要走代理的地方设置走该代理即可

##### 配置路由规则

进入`surge-->代理-->规则-->新建一个规则`，添加容器里面的路由到规则里面

##### 终端使用代理

在当前终端执行`export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153`

退出终端失效，测试不能用ping,ping不是http协议和socks5协议，用`curl -vv https://www.google.com`

##### 终端使用ssh代理

`ssh -o "ProxyCommand=nc -X 5 -x 127.0.0.1:6153 %h %p" root@10.1.1.10`

##### royal TSX使用代理

`连接右键-->properties-->advanced-->SSH-->Additional SSH Options`添加该内容`-o "ProxyCommand=nc -X 5 -x 127.0.0.1:6153 %h %p"`
