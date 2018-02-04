# SPI_Server
	KVM及びDokerコンテナで構成する 3層システム

## SLB
	- nginxを利用したHTTPロードバランサ
	- Dokerコンテナで準備
### 構成物
	- DokerFile
	- Nginx設定ファイル

## APサーバ
	- Python
	- 2台構成
### 構成物
	- KVMインストールスクリプト
	- Python API用コード
	
## DBサーバ
	- MySQL
	- 2台構成
	- レプリケーションでデータ同期
	- ペースメーカを利用したアクティブスタンバイ構成
### 構成物
	- KVM用インストールスクリプト
	- MySQL設定ファイル
	- データベース初期構築用SQL
	- ペースメーカ設定ファイル