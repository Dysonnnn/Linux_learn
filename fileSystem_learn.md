# tmpfs
>tmpfs,临时文件系统，是一种基于内存的文件系统，它和虚拟磁盘ramdisk比较类似像，但不完全相同，和ramdisk一样，tmpfs可以使用RAM，但它也可以使用swap分区来存储，而且传统的ramdisk是个块设备，要用mkfs来格式化它，才能真正地使用它；而tmpfs是一个文件系统，并不是块设备，只是安装它，就可以使用了。tmpfs是最好的基于RAM的文件系统。

- tmpfs 占用内存RAM或者交换交换空间swap的空间



- 备份系统
1. dpkg打包软件，debian-cd打包系统