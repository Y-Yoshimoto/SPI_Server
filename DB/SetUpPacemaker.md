# Pacemakerのセットアップ(MySQL)

## Pacemakerのインストール
```bash
yum -y install pacemaker pcs
systemctl start pcsd
systemctl enable pcsd
```

## Pacemaker用のユーザの設定
```bash
passwd hacluster
```

## クラスターの接続確立及び構成
以降については、マスター側のサーバで実施していく
```bash
pcs cluster auth DBServer1 DBServer2    #少し時間がかかる
pcs cluster setup --name DBCluster DBServer1 DBServer2
```

## クラスターの起動設定
```bash
pcs cluster start --all
pcs cluster enable --all
pcs status cluster
pcs status corosync
```

# VIPリソース設定

## STONITH(:スプリットブレイン対策)のオプションを無効にしておく
```bash
pcs property set stonith-enabled=false
```

## 自動フェイルバックを無効にする
```bash
pcs property set default-resource-stickiness="INFINITY"
```

## VPIリソースを設定する
```bash
pcs resource create Virtual_IP ocf:heartbeat:IPaddr2 ip=192.168.122.5 cidr_netmask=24 op monitor interval=10s
```

## 設定確認
```bash
pcs property list
pcs status resources
```

# MySQLリソースの設定
```bash
pcs cluster standby DBServer2       #2系をスタンバイにする
pcs resource create MySQL ocf:heartbeat:mysql
pcs resource update MySQL systemd:crond                       # mysql起動スクリプト
pcs resource update MySQL pid=/run/mysqld/mysql.pid           # PIDファイルの指定
pcs resource update MySQL replication_user=replication        # レプリケーションユーザ
pcs resource update MySQL replication_passwd=SlavePassword    # レプリケーションパスワード
pcs resource update MySQL datadir=/var/lib/mysql              # データ格納先
pcs resource update MySQL log=/var/log/mysqld.log             # ログファイルの格納場所

pcs cluster cib MySQL_resource.cib                            # 設定ファイルの出力
pcs config                                                    # 設定の確認
```
## MySQLリソースの起動
```bash
pcs resource group add MySQL-cluster Virtual_IP MySQL         #リソースグループの作成
pcs status resources
# マスタースレーブ構成でクラスター設定
pcs resource master MySQL-clone MySQL-cluster master-max=1 master-node-max=1 clone-max=2 clone-node-max=1 notify=true

pcs cluster start DBServer2 # 2系を起動し、状態を確認
pcs status cluster
pcs resource start MySQL-clone
pcs resource enable MySQL-clone
```
