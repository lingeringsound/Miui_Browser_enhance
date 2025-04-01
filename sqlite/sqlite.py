import json
import time
import sqlite3
import tempfile
import zipfile
import os


# 定义变量

#Css定义
css_file = os.path.join(os.path.dirname(__file__), 'output/css_folder')
css_folder_path = css_file
css_rules_files = os.listdir(css_folder_path)

#Domian定义
domain_file = os.path.join(os.path.dirname(__file__), 'output/domain_folder')
domain_folder_path = domain_file
domain_rules_files = os.listdir(domain_folder_path)

#sqlite文件定义
target_sqlite_file = os.path.join(os.path.dirname(__file__), 'Marked_Ads.db')
output_Rules_db_file = os.path.join(os.path.dirname(__file__), 'Marked Ads' )


#创建MIUI浏览器广告标记db数据库文件

conn = sqlite3.connect(target_sqlite_file)
cur = conn.cursor()
cur.execute("PRAGMA foreign_keys=OFF")
cur.execute("BEGIN TRANSACTION")
cur.execute("CREATE TABLE meta(key LONGVARCHAR NOT NULL UNIQUE PRIMARY KEY, value LONGVARCHAR)")
cur.execute("INSERT INTO meta VALUES('mmap_status','-1')")
cur.execute("INSERT INTO meta VALUES('version','1')")
cur.execute("INSERT INTO meta VALUES('last_compatible_version','1')")
cur.execute("CREATE TABLE rules (creation_utc INTEGER NOT NULL UNIQUE PRIMARY KEY,host TEXT NOT NULL,rule TEXT NOT NULL,rule_type INTEGER NOT NULL)")
cur.execute("INSERT INTO rules VALUES(13314687420039749,'','##HTML > BODY > DIV:nth-child(1) > DIV:nth-child(2) > DIV:nth-child(3) > A:nth-child(1)',1)")
cur.execute("INSERT INTO rules VALUES(13323876304328371,'yhdm01.com','||yhdm*.com/js/wap2-jm-ms.js$script',2)")
cur.execute("INSERT INTO rules VALUES(13327167841189902,'www.827txt.com','www.827txt.com##HTML > BODY > DIV:nth-child(50)',1)")
cur.execute("INSERT INTO rules VALUES(13327329248610851,'www.dm99.me','www.dm99.me##HTML > BODY > DIV:nth-child(62)',1)")
conn.commit()
conn.close()



# 添加Css规则
id = 66666
total = 0
for url in css_rules_files:
# 读取文件名称
    filename = url
    filename_path = os.path.join(css_folder_path, filename)
# 以utf-8(Linux) 方式打开文件
    with open(filename_path, 'r', encoding='utf-8') as file:
             content = file.read()
    while(True):
        try:
            res = content
            if(res):
                lines = res.split('\n')
                length = len(lines)
                print("开始添加 %s，共计 %d 条 " % (filename, length))
                for line in lines:
                    if(line.startswith('[') or line.startswith('!') or (not line)):
                        length -= 1
                        continue
                    else:
#                       规定Adblock规则的类型(Css修饰/域名)
                        rules_type_number = '1'
#                        读取规则
                        rule_single = line
#                        指定生效域名一般填空，因为MIUI会识别为全局生效
                        rules_hosts = ''
#                        写入指定的sqlite文件
                        con = sqlite3.connect( target_sqlite_file )
                        cur = con.cursor()
                        cur.execute("INSERT INTO rules (host, rule, rule_type) VALUES(?, ?, ?)", (rules_hosts, rule_single, rules_type_number))
                        con.commit()
                        con.close()
                        id += 1
                        percent = (id - 66666 - total) / length
                        print("进度：{:.1%} [{}/{}]".format(percent, id - 66666 - total, length), end='\r')
                print("\n%s 添加完成\n" % filename)
                total += length
                break
        except Exception as err:
            url = _url
            print(err)
            print('sleep 3s')
            time.sleep(3)

#domain添加，与上面基本一致，不再缀叙
id = 66666
total = 0
for url in domain_rules_files:
    filename = url
    filename_path = os.path.join(domain_folder_path, filename)
    with open(filename_path, 'r', encoding='utf-8') as file:
             content = file.read()
    while(True):
        try:
            res = content
            if(res):
                lines = res.split('\n')
                length = len(lines)
                print("开始添加 %s，共计 %d 条 " % (filename, length))
                for line in lines:
                    if(line.startswith('[') or line.startswith('!') or (not line)):
                        length -= 1
                        continue
                    else:
                        rules_type_number = '2'
                        rule_single = line
                        rules_hosts = ''
                        con = sqlite3.connect( target_sqlite_file )
                        cur = con.cursor()
                        cur.execute("INSERT INTO rules (host, rule, rule_type) VALUES(?, ?, ?)", (rules_hosts, rule_single, rules_type_number))
                        con.commit()
                        con.close()
                        id += 1
                        percent = (id - 66666 - total) / length
                        print("进度：{:.1%} [{}/{}]".format(percent, id - 66666 - total, length), end='\r')
                print("\n%s 添加完成\n" % filename)
                total += length
                break
        except Exception as err:
            url = _url
            print(err)
            print('sleep 3s')
            time.sleep(3)

#重命名文件
os.rename(target_sqlite_file, output_Rules_db_file)

