# tinycore64-cn

tce-load -wi unifont #安装中文字体
下载yong.tcz到/etc/sysconfig/tcedir/optional/下
添加yong.tcz到/etc/sysconfig/tcedir/onboot.lst里
#输入法环境变量可以设置在~/.xsession里
export GTK_IM_MODULE=yong
export XMODIFIERS=@im=yong
export QT_IM_MODULE=yong
yong -d
