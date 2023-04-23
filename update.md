## MIUI 浏览器增强

描述：恢复MIUI 浏览器的广告拦截功能，将会用到 **chattr** 命令防止恢复，请了解下 [chattr](https://www.cnbugs.com/post-3216.html)

## 
## 工作原理

①替换[Host](https://cn.bing.com/search?q=%E4%BB%80%E4%B9%88%E6%98%AFHost)

②替换文件，MIUI浏览器的Adblock文件位于 ``/data/data/com.android.browser/files/data/adblock`` 而模块要做的就是复制然后加上 [chattr](https://www.cnbugs.com/post-3216.html) 锁定。

## 说明

> 模块目录( ``/data/adb/modules/MIUI_browser_key`` )下的 ``配置.prop`` 可以更换规则，更改完配置无需重启，直接执行模块目录下的service.sh。

## 蓝奏云链接

### [蓝奏云下载链接](https://keytoolazy.lanzouw.com/b03j6gxra) **密码：666**

- 103
 > 更新规则，修复误杀。
 > ## [蓝奏云下载链接点击转跳](https://keytoolazy.lanzouw.com/b03j6gxra) **密码：666**


