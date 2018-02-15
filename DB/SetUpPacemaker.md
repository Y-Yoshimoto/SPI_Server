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

# クラスターのリソース設定

## STONITH(:スプリットブレイン対策)のオプションを無効にしておく
pcs property set stonith-enabled=false

## 自動フェイルバックを無効にする
pcs property set default-resource-stickiness="INFINITY"

pcs resource create Virtual_IP ocf:heartbeat:IPaddr2 ip=192.168.122.5 cidr_netmask=24 op monitor interval=30s

## 設定確認
pcs property list
pcs status resources
