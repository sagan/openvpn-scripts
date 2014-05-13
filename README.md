openvpn-scripts
===============

自用的用来生成OpenVPN配置文件的Bash脚本。目前仅能够生成 [Static Key](http://openvpn.net/index.php/open-source/documentation/miscellaneous/78-static-key-mini-howto.html) 模式的OpenVPN配置文件。（TLS 模式的 OpenVPN 已经给 GFW 封的基本上用不起来了。）

# Usage

在 OpenVPN 服务器端运行```./setup_static.sh```，按照说明输入相关信息。脚本将生成 Static Key 模式的OpenVPN服务器端配置文件、
客户端配置文件和静态密钥。同时将生成用来启动VPN的服务器端和客户端脚本。

生成的配置文件位于```$HOME/openvpn```目录。

脚本要求输入的信息：

* ID：一个标示符。用于脚本生成的配置文件名前缀。
* Server IP：OpenVPN 服务器端的监听 IP。脚本将列出服务器上所有网卡IP供选择。
* Server Port：OpenVPN 服务器端的监听端口。 
* Subnet Mask C Number：OpenVPN 的私有网段子网掩码 C 段。脚本将把 OpenVPN 的网段设为```192.168.X.0```。


