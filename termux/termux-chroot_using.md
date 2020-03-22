解决termux Android 10无法使用termux-chroot命令
原创NotAlone777 最后发布于2020-03-09 01:23:24 阅读数 2569  收藏
展开
这几天心血来潮去玩termux，结果最难受的是突然发现termux-chroot命令无法使用，经过在茫茫网络中的搜索，终于在GitHub上找到了解决方案。

参考这个问题，大佬们的答案
https://github.com/termux/proot/issues/87

发现修改termux-chroot的脚本后可以完美运行，废话不多说进入正题

第一步：修改termux-chroot脚本
```sh 
vi /data/data/com.termux/files/usr/bin/termux-chroot
# Android 10 needs /apex for /system/bin/linker:
# https://github.com/termux/proot/issues/95#issuecomment-584779998
if [ -d /apex ]; then
	ARGS="$ARGS -b /apex:/apex"
fi
————————————————
版权声明：本文为CSDN博主「NotAlone777」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_39105012/article/details/104744781
```
————————————————
版权声明：本文为CSDN博主「NotAlone777」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_39105012/article/details/104744781