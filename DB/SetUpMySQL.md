#!bin/bash
# yum update -y
rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# MySQL5.7の最新版インストール
yum install mysql-community-server -y
# MySQLの起動及び状態表示
service mysqld start
systemctl status mysqld.service

# ルートパスワードの確認
grep 'temporary password' /var/log/mysqld.log

## 以下手動操作
# mysql -uroot -p
# ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';

# OSイメージをコピー

# マスターサーバの設定
## 設定ファイルの編集
cp /etc/my.cnf /etc/my.cnf.org
echo "character-set-server=utf8" >> /etc/my.cnf
echo "log-bin" >> /etc/my.cnf
echo "server-id=001" >> /etc/my.cnf
systemctl restart mysqld.service
systemctl status mysqld.service
## レプリケーション対象のデータベースを作成
mysql -uroot -p

mysql > create database testDB;

## スレーブが使用するアカウントを作成
create user 'replication'@'%' identified by 'SlavePassword';
grant replication slave on *.* to 'replication'@'%';

## テスト用のDBのダンプファイルを作成
# flush tables with read lock;
show master status;
mysqldump --single-transaction -u root -p testDB > testDB.dump

# スレーブサーバの設定
## 設定ファイルへの追記, UUIDのリセット
echo "server-id=002" >> /etc/my.cnf
echo "character-set-server=utf8" >> /etc/my.cnf
rm /var/lib/mysql/auto.cnf
systemctl restart mysqld.service

## ダンプファイルの読み込み
source ~/testDB.dump;
## マスタDBへの接続情報を設定
mysql> change master to
    -> master_host='192.168.122.94',          # マスターサーバIPアドレス
    -> master_user='replication',                   # 接続用ユーザ名
    -> master_password='SlavePassword',     # 接続用パスワード
    -> master_log_file='DBServer1-bin.000001',  # バイナリログのファイル名
    -> master_log_pos=1330;                     # バイナリログのポジション
    ## バイナリファイル名,ポジションは、マスターDBで"show master status;"を使用して確認

## testDBをレプリケーション用のDBとしてセット
change replication filter replicate_do_db = (testDB);
## スレーブとして起動する
start slave;
show slave status\G
