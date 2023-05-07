#!/bin/sh

#加载公共函数
source "`pwd`/sqlite/util_function.sh"

#定义下载目录
Download_Rules="`pwd`/sqlite/download"

#清理临时文件
clean_up_tmpfile

#下载规则
download_link "https://raw.fgit.ml/lingeringsound/adblock_auto/main/Rules/adblock_auto_lite.txt" "${Download_Rules}"

#读取下载好的Adblock规则
for file in "${Download_Rules}"/*.txt
do
	mkdir_css_Rules "${file}"
	mkdir_domain_Rules "${file}"
done

#生成sqlite文件
python "`pwd`/sqlite/sqlite.py"

rm -rf "`pwd`/sqlite/download" "`pwd`/sqlite/output"



