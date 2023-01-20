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

- v69
 > 添加在线更新
- v73
 > ①更新广告规则和MIUI隐私规则
 > ②如果感觉卡顿，请删除(修改后缀名) ``/data/user/0/com.android.browser/files/data/adblock/miui_privacylist.json`` ，MIUI隐私规则文件，以及模块内的 **Replace_privacy.sh** 脚本。
- v76
 > 更新百度部分规则
 > 删除MIUI占用日志 **zeuslogs** 文件夹
- v77
 > 禁用小米应用商店部分组件
- v78
 > 更新 **hosts** ，如果MIUI14出现问题，不再处理，自己删除模块内的/system文件夹。
  
  