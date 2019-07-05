# something useful command

## get weather
https://www.mivm.cn/linux-curl-weather/
curl -H "Accept-Language: 语言" wttr.in/地名，这个地名可以是很多种，可以是城市名称，如：Beijing（北京）；机场代码，如：PEK（北京首都国际机场）；域名所在位置，如：@mivm.cn（浙江杭州）；GPS 坐标，如：-39.9087191,116.3952003（天安门），还有两个，任意位置和区号，不过那个在国内不好用，所以就不说了，

至于语言，目前支持的语言：az be bg bs ca cy cs da de el eo es et fi fr hi hr hu hy is it ja jv ka kk ko ky lv mk ml nl nn pt pl ro ru sk sl sr sr-lat sv sw th tr uk uz vi zh zu，

比如我在广州，输入
curl -H "Accept-Language: zh" wttr.in/guangzhou


## orute
```bash
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.10.200.1     0.0.0.0         UG    100    0        0 enp0s3
10.10.200.0     *               255.255.254.0   U     100    0        0 enp0s3
link-local      *               255.255.0.0     U     1000   0        0 enp0s3
```