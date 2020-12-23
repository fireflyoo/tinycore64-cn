# tinycore64-cn

tce-load -wi unifont #安装中文字体  
下载yong.tcz到/etc/sysconfig/tcedir/optional/下  
添加yong.tcz到/etc/sysconfig/tcedir/onboot.lst里  
#输入法环境变量可以设置在~/.xsession里  
```bash
export GTK_IM_MODULE=yong  
export XMODIFIERS=@im=yong  
export QT_IM_MODULE=yong  
yong -d  
```
已知BUG  
1.无法在原生X应用下(如aterm/xterm)输入中文.  
2.无法调出输入法设置面板.  
3.未添加自己常用的小鹤双拼输入法.  
