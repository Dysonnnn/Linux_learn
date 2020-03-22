# error
```
u0_axxx@localhost /data/data/com.termux/files/usr/etc/nginx                                           [1:20:46] 
> $ termux-chroot                                                                                              
proot error: execve("/usr/bin/bash"): No such file or directory
proot info: It seems that termux-exec is active and is prepending /data/data/com.termux/... to executable paths
If this is path is not available inside proot, please "unset LD_PRELOAD"
fatal error: see `proot --help`.

```

安卓10用不了 termux-chroot 了。。。。哦不，参考 termux-chroot 使用文档，新增一段判断之后可以了。


nginx无法监听80端口啊，没权限，怎么办？
--去路由器设置端口转发。


