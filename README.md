# checkpoint-snx-snell
需求，电脑想连2个check point vpn，但是网上客户端支持一个

因此另一个打算用snx加容器进行部署然后在用snell来代理到surge上面进行访问，因此需要制作一个snx加上snell的镜像。

采用snell的原因，比较简单，其他的strongSwan、ss都比较复杂。

编译源码件[iexxk/checkpoint-snx-snell](https://github.com/iexxk/checkpoint-snx-snell)

### 使用

```bash
#启动容器
docker run --name snx-vpn --cap-add=ALL -p 500:500 -v /lib/modules:/lib/modules -d exxk/checkpoint-snx-snell:22.9.19
#进入容器
docker exec -it snx-vpn bash
#登录vpn，执行下面的命令会提示输入密码，然后提示是否接受，然后输入y
snx -s 服务svn的ip -u 用户名
#停止容器
docker stop snx-vpn
#删除容器
docker rm snx-vpn
```

#### 自定义修改配置

修改配置可以修改容器内这个`/etc/snell/snell-server.conf`配置文件，可以修改psk密码(如果暴露在外一定要修改密码)和端口

#### 客户端配置

进入surge-->代理-->策略-->规则判断-->新建一个代理

配置

* 服务器地址：容器的宿主机地址（本机就127.0.0.1）
* 端口：默认500
* PSK：默认2iPRYDZyOVfjRwt9
* 混淆：TLS

然后根据那些地址自己要走代理的地方设置走该代理即可
