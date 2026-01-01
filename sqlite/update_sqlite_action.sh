#!/bin/sh

#加载公共函数
source "`pwd`/sqlite/util_function.sh"

#定义下载目录
Download_Rules="`pwd`/sqlite/download"

#清理临时文件
clean_up_tmpfile

#下载规则
download_link "https://lingeringsound.github.io/adblock_auto/Rules/adblock_auto_lite.txt" "${Download_Rules}"

#读取下载好的Adblock规则
for file in "${Download_Rules}"/*.txt
do
	mkdir_css_Rules "${file}"
	mkdir_domain_Rules "${file}"
done

#生成sqlite文件
python "`pwd`/sqlite/sqlite.py"

#更新 README 信息
update_README_info

#删除临时文件夹
rm -rf "`pwd`/sqlite/download" "`pwd`/sqlite/output"

if test -f "`pwd`/sqlite/Marked Ads" ;then
	cd "`pwd`/sqlite"
	zip -r9 "`pwd`/Marked_Ads_database.zip" ./'Marked Ads' && echo "※`date +'%F %T'`压缩包位置: `pwd`/Marked_Ads_database.zip "
fi
