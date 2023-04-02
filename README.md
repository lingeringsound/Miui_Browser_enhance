## MIUI 浏览器增强

描述：恢复MIUI 浏览器的广告拦截功能，将会用到 **chattr** 命令防止恢复，请了解下 [chattr](https://www.cnbugs.com/post-3216.html)

## 
### 合并 **源** 

#### 如下，感谢各位大佬的规则！

| **名称** | **链接** |
| :-- | :-- |
| ***乘风*** | [link](https://cdn.jsdelivr.net/gh/xinggsf/Adblock-Plus-Rule@master/rule.txt) |
| ***360 rules*** | [link](https://code.gitlink.org.cn/api/v1/repos/keytoolazy/adblock/raw/Qihoo_Adblock_108) | 
| ***Adblock Plus EasylistChina*** | [link](https://easylist-downloads.adblockplus.org/easylistchina.txt) |
## 
## 工作原理

①替换[Host](https://cn.bing.com/search?q=%E4%BB%80%E4%B9%88%E6%98%AFHost)

②替换文件，MIUI浏览器的Adblock文件位于 ``/data/data/com.android.browser/files/data/adblock`` 而模块要做的就是复制然后加上 [chattr](https://www.cnbugs.com/post-3216.html) 锁定。

## 说明

> 模块目录( ``/data/adb/modules/MIUI_browser_key`` )下的 ``配置.prop`` 可以更换规则，更改完配置无需重启，直接执行模块目录下的service.sh。

## 访问人量 : ![visitors](https://visitor-badge.glitch.me/badge?page_id=lingeringsound.Miui_Browser_enhance&left_color=green&right_color=red)
