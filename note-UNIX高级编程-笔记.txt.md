unix/linux中书中一直提到的“ourhdr.h”文件内容

https://blog.csdn.net/acb0y/article/details/6540436

```
/*Our own header, to be included after  all standard system headers*/
#ifndef __ourhdr_h  
#define __ourhdr_h  
#include    <errno.h>/*for definition of errno */
#include    <stdarg.h>/*ANSI C header file*/
#include        <sys/types.h>   /* required for some of our prototypes */  
#include        <stdio.h>               /* for convenience */  
#include        <stdlib.h>              /* for convenience */  
#include        <string.h>              /* for convenience */  
#include        <unistd.h>              /* for convenience */  
#define MAXLINE 4096                    /* max line length */  
#define FILE_MODE       (S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)  
                                        /* default file access permissions for new files */  
#define DIR_MODE        (FILE_MODE | S_IXUSR | S_IXGRP | S_IXOTH)  
                                        /* default permissions for new directoris */  
typedef void    Sigfunc(int);   /* for signal handlers */  
                                        /* 4.3BSD Reno <signal.h> doesn't define  
SIG_ERR */  
#if     defined(SIG_IGN) && !defined(SIG_ERR)  
#define SIG_ERR ((Sigfunc *)-1)  
#endif  
#define min(a,b)        ((a) < (b) ? (a) : (b))  
#define max(a,b)        ((a) > (b) ? (a) : (b)) 
                                        /* prototypes for our own functions */  
char    *path_alloc(int *);                     /* {Prog pathalloc} */  
int              open_max(void);                        /* {Prog openmax} */  
void     clr_fl(int, int);                      /* {Prog setfl} */  
void     set_fl(int, int);                      /* {Prog setfl} */  
void     pr_exit(int);                          /* {Prog prexit} */  
void     pr_mask(const char *);         /* {Prog prmask} */  
Sigfunc *signal_intr(int, Sigfunc *);/* {Prog signal_intr_function} */  
int              tty_cbreak(int);                       /* {Prog raw} */  
int              tty_raw(int);                          /* {Prog raw} */  
int              tty_reset(int);                        /* {Prog raw} */  
void     tty_atexit(void);                      /* {Prog raw} */  
#ifdef  ECHO    /* only if <termios.h> has been included */  
struct termios  *tty_termios(void);     /* {Prog raw} */  
#endif  
void     sleep_us(unsigned int);        /* {Ex sleepus} */  
ssize_t  readn(int, void *, size_t);/* {Prog readn} */  
ssize_t  writen(int, const void *, size_t);/* {Prog writen} */  
int              daemon_init(void);                     /* {Prog daemoninit} */  
int              s_pipe(int *);                         /* {Progs svr4_spipe bsd  spipe} */  
int              recv_fd(int, ssize_t (*func)(int, const void *, size_t));  
                                                                        /* {Prog   recvfd_svr4 recvfd_43bsd} */  
int              send_fd(int, int);                     /* {Progs sendfd_svr4 se  dfd_43bsd} */  
int              send_err(int, int, const char *);/* {Prog senderr} */  
int              serv_listen(const char *);     /* {Progs servlisten_svr4 servli  ten_4  4bsd} */  
int              serv_accept(int, uid_t *);     /* {Progs servaccept_svr4 servac  ept_4  4bsd} */  
int              cli_conn(const char *);        /* {Progs cliconn_svr4 cliconn_4  bsd} */  
int              buf_args(char *, int (*func)(int, char **));  
                                                                        /* {Prog  bufargs} */  
int              ptym_open(char *);                     /* {Progs ptyopen_svr4 p  yopen_44bsd} */  
int              ptys_open(int, char *);        /* {Progs ptyopen_svr4 ptyopen_4  bsd} */  
#ifdef  TIOCGWINSZ  
pid_t    pty_fork(int *, char *, const struct termios *,  
                                  const struct winsize *);      /* {Prog ptyfork   */  
#endif  
int             lock_reg(int, int, int, off_t, int, off_t);  
                                                                        /* {Prog  lockreg} */  
#define read_lock(fd, offset, whence, len)    lock_reg(fd, F_SETLK, F_RDLCK, offset, whence, len)  
#define readw_lock(fd, offset, whence, len)       lock_reg(fd, F_SETLKW, F_RDLCK, offset, whence, len)  
#define write_lock(fd, offset, whence, len)           lock_reg(fd, F_SETLK, F_WRLCK, offset, whence, len)  
#define writew_lock(fd, offset, whence, len)           lock_reg(fd, F_SETLKW, F_WRLCK, offset, whence, len)  
#define un_lock(fd, offset, whence, len)                  lock_reg(fd, F_SETLK, F_UNLCK, offset, whence, len)  
pid_t   lock_test(int, int, off_t, int, off_t);  
 /* {Prog    locktest} */  
#define is_readlock(fd, offset, whence, len)                         lock_test(fd, F_RDLCK, offset, whence, len)  
#define is_writelock(fd, offset, whence, len)                         lock_test(fd, F_WRLCK, offset, whence, len)  
void    err_dump(const char *, ...);    /* {App misc_source} */  
void    err_msg(const char *, ...);  
void    err_quit(const char *, ...);  
void    err_ret(const char *, ...);  
void    err_sys(const char *, ...);  
void    log_msg(const char *, ...);             /* {App misc_source} */  
void    log_open(const char *, int, int);  
void    log_quit(const char *, ...);  
void    log_ret(const char *, ...);  
void    log_sys(const char *, ...);  
void    TELL_WAIT(void);                /* parent/child from {Sec race_condition  } */  
void    TELL_PARENT(pid_t);  
void    TELL_CHILD(pid_t);  
void    WAIT_PARENT(void);  
void    WAIT_CHILD(void);  
#endif  /* __ourhdr_h */
```





linux下运行《UNIX环境高级编程》的第一个程序时源码编译出错的处理方法
https://blog.csdn.net/abc5382334/article/details/18518423


会出现下面的错误：
: undefined reference to `err_quit'
: undefined reference to `err_sys'
解决办法：
因为err_quit跟err_sys是作者自己定义的错误处理函数,需要单独定义头文件

在/usr/include 下新建一个名为myerr.h的文件

里面的内容为

```
#include "apue.h"
#include <errno.h>      /* for definition of errno */
#include <stdarg.h>     /* ISO C variable aruments */
 
static void err_doit(int, int, const char *, va_list);
 
/*
* Nonfatal error related to a system call.
* Print a message and return.
*/
void
err_ret(const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(1, errno, fmt, ap);
    va_end(ap);
}
 
/*
* Fatal error related to a system call.
* Print a message and terminate.
*/
void
err_sys(const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(1, errno, fmt, ap);
    va_end(ap);
    exit(1);
}
 
/*
* Fatal error unrelated to a system call.
* Error code passed as explict parameter.
* Print a message and terminate.
*/
void
err_exit(int error, const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(1, error, fmt, ap);
    va_end(ap);
    exit(1);
}
 
/*
* Fatal error related to a system call.
* Print a message, dump core, and terminate.
*/
void
err_dump(const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(1, errno, fmt, ap);
    va_end(ap);
    abort();        /* dump core and terminate */
    exit(1);        /* shouldn't get here */
}
 
/*
* Nonfatal error unrelated to a system call.
* Print a message and return.
*/
void
err_msg(const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(0, 0, fmt, ap);
    va_end(ap);
}
 
/*
* Fatal error unrelated to a system call.
* Print a message and terminate.
*/
void
err_quit(const char *fmt, ...)
{
    va_list     ap;
 
    va_start(ap, fmt);
    err_doit(0, 0, fmt, ap);
    va_end(ap);
    exit(1);
}
 
/*
* Print a message and return to caller.
* Caller specifies "errnoflag".
*/
static void
err_doit(int errnoflag, int error, const char *fmt, va_list ap)
{
    char    buf[MAXLINE];
   vsnprintf(buf, MAXLINE, fmt, ap);
   if (errnoflag)
       snprintf(buf+strlen(buf), MAXLINE-strlen(buf), ": %s",
         strerror(error));
   strcat(buf, " ");
   fflush(stdout);     /* in case stdout and stderr are the same */
   fputs(buf, stderr);
   fflush(NULL);       /* flushes all stdio output streams */
}
```
--------------------- 
接下来在ls.c里面引用#include<myerr.h>就好了。

在运行程序
gcc ls.c 

./a.out /home

就可以看到你home目录下面的内容了

作者：叶子一哥 
来源：CSDN 
原文：https://blog.csdn.net/abc5382334/article/details/18518423 
版权声明：本文为博主原创文章，转载请附上博文链接！



---



关于unix高级环境编程 编译时的err_sys和err_quit错误
https://blog.csdn.net/cuiyifang/article/details/8288649
 err_sys以及err_quit等函数不是C语言自带函数，是作者自己编写的函数。所以，想要运行书中的源代码，就必须自建一个头文件my_err.h把作者的代码拷贝进去，然后在程序中加载。




[转载]Undefined reference to err_sys 的解决 (2011-07-07 15:39:35)
http://blog.sina.com.cn/s/blog_5d2f92360100s4rl.html
 最直接的解决方法用printf()方法来代替err_sys();

 