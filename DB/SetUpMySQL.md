#!bin/bash
# yum update -y
rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# MySQL5.7の最新版インストール
yum install mysql-community-server -y
# MySQLの起動及び状態表示
systemctl start mysqld.service
systemctl status mysqld.service

# ルートパスワードの確認
grep 'temporary password' /var/log/mysqld.log

## 以下手動操作
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Pass';
## パスワードの更新
use mysql;
UPDATE user SET authentication_string=password('pass') WHERE user='root';

# OSイメージをコピー

# マスターサーバの設定
## 設定ファイルの編集
cp -p /etc/my.cnf /etc/my.cnf.org
echo "character-set-server=utf8" >> /etc/my.cnf     # 文字コード編集
echo "log-bin=mysql-bin" >> /etc/my.cnf
echo "server-id=001" >> /etc/my.cnf
echo "expire_logs_days=3" >> /etc/my.cnf # 3日でローテション
systemctl restart mysqld.service
systemctl status mysqld.service
## レプリケーション対象のデータベースを作成
mysql -u root -p

mysql > create database testDB;

## スレーブが使用するアカウントを作成
create user 'replication'@'%' identified by 'SlavePassword';
grant replication slave on *.* to 'replication'@'%';

## テスト用のDBのダンプファイルを作成
# flush tables with read lock;
show master status\G
mysqldump --single-transaction -u root -p testDB > testDB.dump


# スレーブサーバの設定
## 設定ファイルへの追記, UUIDのリセット
echo "server-id=002" >> /etc/my.cnf
echo "character-set-server=utf8" >> /etc/my.cnf
rm /var/lib/mysql/auto.cnf
systemctl restart mysqld.service

## ダンプファイルの読み込み
mysql -u root -p
create database testDB;

mysql -u root -p testDB < testDB.dump
## マスタDBへの接続情報を設定
## バイナリファイル名,ポジションは、マスターDBで"show master status;"を使用して確認
mysql> change master to
    -> master_host='192.168.122.239',           # マスターサーバIPアドレス
    -> master_user='replication',               # 接続用ユーザ名
    -> master_password='SlavePassword',         # 接続用パスワード
    -> master_log_file='DBServer1-bin.000001',  # バイナリログのファイル名
    -> master_log_pos=522;                     # バイナリログのポジション

## testDBをレプリケーション用のDBとしてセット
change replication filter replicate_do_db = (testDB);
## スレーブとして起動する
start slave;
show slave status\G


# 接続用ユーザの追加
grant all privileges on testDB.* to DBuser@"%" identified by 'passwd' with grant option;

## パスワードのルールを緩和
```bash
SET GLOBAL validate_password_length=4;
SET GLOBAL validate_password_policy=LOW;
SHOW VARIABLES LIKE 'validate_password%';
```
