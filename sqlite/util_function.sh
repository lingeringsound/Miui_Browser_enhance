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
local CSS_Rules=`cat "${ad_fiter}" 2>/dev/null | sed 's|“|"|g;s|”|"|g' | sed '/^!/d;/^[[:space:]]*$/d;/^\[.*\]$/d' | grep -E '#' | grep -Ev "^\|\|"`
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
}





