
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

## Marked Ads 文件说明
#### [Marked Ads](https://raw.fgit.ml/lingeringsound/Miui_Browser_enhance/main/sqlite/Marked%20Ads) 文件为MIUI就浏览器广告标记文件。
### 说明
 > #### 文件路径 `/data/data/com.android.browser/app_miui_webview/Marked Ads`
 > #### 文件类型 `database` 数据库存储文件
### 文件内容解析
 > #### 第一行: chrome 记录的时间戳
 > #### 第二行: Adblock规则作用的域名(建议填空)
 > #### 第三行: Adblock规则
 > #### 第四行: Adblock规则的类型
 > ##### 以"#"或者域名后面带"#"号的则为css修饰规则，需要填"1"
 > ##### 以"||"或者"."之类为域名拦截规则，需要填"2"。
### 制作的好的标记文件(2026-01-01 09:47:18)
 > #### 订阅源: [混合规则精简版](https://lingeringsound.github.io/adblock_auto/Rules/adblock_auto_lite.txt)
 > #### 下载链接: [点击下载](https://lingeringsound.github.io/Miui_Browser_enhance/sqlite/Marked%20Ads)


