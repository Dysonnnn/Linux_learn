[如何在Ubuntu 16.04上增加Swap分区](https://blog.csdn.net/u010429286/article/details/79219230)


2018年01月31日 16:43:16 我是康小小 阅读数：4573
翻译自：How To Add Swap Space on Ubuntu 16.04

前言

提高服务器响应速度和防止应用程序内存不足错误的最简单方法之一是添加一些交换空间。 在本指南中，我们将介绍如何将交换文件添加到Ubuntu 16.04服务器。

但是，请注意：

尽管swap区通常建议用于使用传统旋转硬盘驱动器的系统，但使用与SSD交换可能会导致随着时间的推移硬件退化问题。 由于这个考虑，我们不建议在DigitalOcean或任何其他使用SSD存储的供应商上启用swap分区。 这样做可能会影响到您和您的邻居的底层硬件的可靠性。 本指南仅供可能在其他地方有使用旋转磁盘系统的用户参考。如果您需要改善DigitalOcean服务器的性能，我们建议升级您的Droplet，以致于有更好的体验，并且会降低影响您的服务的硬件问题的可能性。

1.首先来了解一下什么是Swap

Swap分区（也称交换分区）是硬盘上的一个区域，被指定为操作系统可以临时存储数据的地方，这些数据不能再保存在RAM中。 基本上，这使您能够增加服务器在工作“内存”中保留的信息量，但有一些注意事项，主要是当RAM中没有足够的空间容纳正在使用的应用程序数据时，将使用硬盘驱动器上的交换空间。

写入磁盘的信息将比保存在RAM中的信息慢得多，但是操作系统更愿意将应用程序数据保存在内存中，并使用交换旧数据。 总的来说，当系统的RAM耗尽时，将交换空间作为回落空间可能是一个很好的安全网，可防止非SSD存储系统出现内存不足的情况。

2.检查系统的交换信息

在开始之前，我们可以检查系统是否已经有一些可用的交换空间，可能有多个交换文件或交换分区，但通常应该是足够的。我们可以通过如下的命令来查看系统是否有交换分区：
```bash
$ sudo swapon --show
```
如果没有任何结果或者没有任何显示，说明系统当前没有可用的交换空间。也可以使用free工具来验证当前确实没有可用的交换分区。
```bash
$ free -h
```
输出结果：
```bash
              total        used        free      shared  buff/cache   available
Mem:           488M         36M        104M        652K        348M        426M
Swap:            0B          0B          0B
```
可以看到这里的”swap”行均为0，也就是说系统上没有交换处于活动状态。

3.检查硬盘驱动器分区上的可用空间

为swap分配空间的最常见方式是使用专门用于具体某个任务的单独分， 但是，改变分区方案并不是一定可行的，我们只是可以轻松地创建驻留在现有分区上的交换文件。

在开始之前，我们应该通过输入以下命令来检查当前磁盘的使用情况：
```bash
$ df -h
```
输出结果：
```bash
Filesystem      Size  Used Avail Use% Mounted on
udev            238M     0  238M   0% /dev
tmpfs            49M  624K   49M   2% /run
/dev/vda1        20G  1.1G   18G   6% /
tmpfs           245M     0  245M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           245M     0  245M   0% /sys/fs/cgroup
tmpfs            49M     0   49M   0% /run/user/1001
```

在这种情况下，/dev下的设备是我们的磁盘。在这个例子中我们有足够的空间（只使用了1.1G），当然，您的使用情况可能会有所不同。

尽管对于交换空间的适当大小有许多意见，但这取决于您的个人偏好和应用程序要求。 一般来说，相当于系统内存量的两倍或者两倍是一个很好的起点。 另一个很好的经验是，如果你只是把它用作RAM备用，那么swap分区的大小尽量不要超过4 GB。

4.创建swap文件

现在我们知道了可用的硬盘空间，那我们就可以在文件系统中创建一个交换文件，我们将在我们的根（/）目录下创建一个名为swapfile的文件。创建交换文件最好的方法是使用fallocate命令，这个命令能立即创建一个预分配大小的文件。由于本示例中的服务器RAM的大小为512MB，因此我们将在本教程中创建一个1 GB大小的文件，并适当加以调整，以满足您自己的服务器的需求：
```bash
$ sudo fallocate -l 1G /swapfile
```
创建完成之后，我们可以通过这个命令来验证是否保留了正确的交换空间：
```bash
$ ls -lh /swapfile
```
显示结果：
```bash
$ -rw-r--r-- 1 root root 1.0G Apr 25 11:14 /swapfile
```
这就说明我们的文件已经创建了正确的空间大小。

5.启用交换文件

现在我们有一个1 GB大小的文件，我们需要把它变成交换空间

首先，我们需要锁定文件的权限，以便只有拥有root权限的用户才能读取文件内容，这可以防止普通用户能够访问该文件，以免造成重大的安全隐患。

锁定文件的root权限：
```bash
$ sudo chmod 600 /swapfile
```
验证权限：
```bash
$ ls -lh /swapfile
```
显示结果：
```bash
-rw------- 1 root root 1.0G Apr 25 11:14 /swapfile
```
可以看到，只有root用户启用了读写标志。

接下来，我们可以通过以下命令将文件标记为交换空间
```bash
$ sudo mkswap /swapfile
```
显示结果：
```bash
Setting up swapspace version 1, size = 1024 MiB (1073737728 bytes)
no label, UUID=6e965805-2ab9-450f-aed6-577e74089dbf
```

标记文件之后，我们可以启用该交换文件，让我们的系统开始使用它：
```bash
$ sudo swapon /swapfile
```
可以通过以下命令验证交换空间是否可用：
```bash
$ sudo swapon --show
```
显示结果：
```bash
NAME      TYPE  SIZE USED PRIO
/swapfile file 1024M   0B   -1
```

这时，我们可以通过free再次查看我们的设置：
```bash
$ free -h
```

显示结果：
```bash
              total        used        free      shared  buff/cache   available
Mem:           488M         37M         96M        652K        354M        425M
Swap:          1.0G          0B        1.0G
```


可以看到swap分区已成功创建，大小为1.0 G，操作系统将在必要时使用。

6.永久保留交换文件

我们最近的更改启用了当前会话的swap文件，但是，如果我们重新启动，服务器不会自动保留swap设置，我们可以通过将swap文件添加到/etc/fstab文件中来改变这一点。

备份/etc/fstab文件以防出错：

```bash
$ sudo cp /etc/fstab /etc/fstab.bak
```
将swap文件信息添加到/etc/fstab文件的末尾：

```bash
$ echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

这样就保留了swap文件。