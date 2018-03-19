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

## VIPリソースを設定する
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
pcs cluster standby DBServer2                                   #2系をスタンバイにする
pcs resource describe systemd:mysqld                            # mysqlリソースのオプションを確認
pcs resource create MySQL systemd:mysqld                        # mysqlリソースの設定
pcs resource update MySQL op monitor interval=10 timeout=50     # 監視のインターバル,タイムアウトを設定
pcs resource clone MySQL                                        # mysqlリソースをクローン起動する
pcs constraint colocation add Virtual_IP with MySQL-clone       # VIPとMySQLが同じノードで動くように設定
pcs cluster cib MySQL_resource.cib                              # 設定ファイルの出力
pcs config                                                      # 設定の確認
```
## MySQLクラスターの起動
```bash
pcs cluster unstandby DBServer2 # 2系をスタート
pcs status cluster              # クラスターの状態確認
pcs status resources            # リソースの状態確認
```
