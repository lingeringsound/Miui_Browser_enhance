#!/bin/sh

export "PATH=$PATH:/data/data/com.termux/files/usr/bin"

#准备函数
function mk_new_file(){
	local file="${1}"
	local new=`cat ${file} | iconv -t 'utf8' | sed 's|^[[:space:]]@@|@@|g;s|“|"|g;s|”|"|g' | sort | uniq | sed '/^!/d;/^[[:space:]]*$/d;/^\[.*\]$/d'`
	echo "${new}" > "${file}"
}

function download_link(){
local IFS=$'\n'
local target_dir="${2}"
local URL="${1}"
local name=`date +%s`
test "${target_dir}" = "" && target_dir="`pwd`/sqlite/download"
mkdir -p "${target_dir}"
test ! -f "${target_dir}/${name}.txt" && curl -k -L -o "${target_dir}/${name}.txt" "${URL}" >/dev/null 2>&1 && echo "※ `date +'%F %T'` ${URL} 下载成功！\n"
dos2unix "${target_dir}/${name}.txt" >/dev/null 2>&1
}

function Combine_adblock_original_file(){
local file="${1}"
local target_folder="${2}"
test "${target_folder}" = "" && echo "※`date +'%F %T'` 请指定合并目录……" && exit
for i in "${target_folder}"/*.txt
do
	dos2unix "${i}" >/dev/null 2>&1
	echo "`cat "${i}"`" >> "${file}"
done
}

function mkdir_css_Rules(){
local ad_fiter="${1}"
test ! -f "${ad_fiter}" && return
local CSS_Rules=`cat "${ad_fiter}" 2>/dev/null | sed 's|“|"|g;s|”|"|g' | sed '/^!/d;/^[[:space:]]*$/d;/^\[.*\]$/d' | grep -E '#' | grep -Ev "^\|\|##\.iframe|##iframe|iframe\[|#\@#iframe|#\@#\.iframe"`
local output_folder="`pwd`/sqlite/output/css_folder"
mkdir -p "${output_folder}"
echo "${CSS_Rules}" >> "${output_folder}/${ad_fiter##*/}_css.txt"
mk_new_file "${output_folder}/${ad_fiter##*/}_css.txt"
}

function mkdir_domain_Rules(){
local ad_fiter="${1}"
test ! -f "${ad_fiter}" && return
local Domain_Rules=`cat "${ad_fiter}" 2>/dev/null | sed 's|“|"|g;s|”|"|g' | sed '/^!/d;/^[[:space:]]*$/d;/^\[.*\]$/d' | grep -Ev "##|#\@#|#\?#"`
local output_folder="`pwd`/sqlite/output/domain_folder"
mkdir -p "${output_folder}"
echo "${Domain_Rules}" >> "${output_folder}/${ad_fiter##*/}_domain.txt"
mk_new_file "${output_folder}/${ad_fiter##*/}_domain.txt"
}


function clean_up_tmpfile(){
test -d "`pwd`/sqlite/output" && rm -rf "`pwd`/sqlite/output"
test -f "`pwd`/sqlite/Marked_Ads.db" && rm -rf "`pwd`/sqlite/Marked_Ads.db"
test -f "`pwd`/sqlite/Marked Ads" && rm -rf "`pwd`/sqlite/Marked Ads"
}

function update_README_info(){

cat << key > `pwd`/README.md

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
②替换文件，MIUI浏览器的Adblock文件位于 \`\`/data/data/com.android.browser/files/data/adblock\`\` 而模块要做的就是复制然后加上 [chattr](https://www.cnbugs.com/post-3216.html) 锁定。
## 说明

> 模块目录( \`\`/data/adb/modules/MIUI_browser_key\`\` )下的 \`\`配置.prop\`\` 可以更换规则，更改完配置无需重启，直接执行模块目录下的service.sh。

## Marked Ads 文件说明
#### [Marked Ads](https://raw.fgit.ml/lingeringsound/Miui_Browser_enhance/main/sqlite/Marked%20Ads) 文件为MIUI就浏览器广告标记文件。
### 说明
 > #### 文件路径 \`/data/data/com.android.browser/app_miui_webview/Marked Ads\`
 > #### 文件类型 \`database\` 数据库存储文件
### 文件内容解析
 > #### 第一行: chrome 记录的时间戳
 > #### 第二行: Adblock规则作用的域名(建议填空)
 > #### 第三行: Adblock规则
 > #### 第四行: Adblock规则的类型
 > ##### 以"#"或者域名后面带"#"号的则为css修饰规则，需要填"1"
 > ##### 以"||"或者"."之类为域名拦截规则，需要填"2"。
### 制作的好的标记文件(`date +'%F %T'`)
 > #### 订阅源: [混合规则精简版](https://lingeringsound.github.io/adblock_auto/Rules/adblock_auto_lite.txt)
 > #### 下载链接: [点击下载](https://lingeringsound.github.io/Miui_Browser_enhance/sqlite/Marked%20Ads)


key

}



