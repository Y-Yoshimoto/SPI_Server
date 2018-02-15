# mysql_secure_installation

mysqlの初期設定について

### rootパスワードの変更有無:No
```bash
Change the password for root ? ((Press y|Y for Yes, any other key for No) :
```
### 匿名ユーザの削除:Yes
```bash
Remove anonymous users? (Press y|Y for Yes, any other key for No) :
```
### rootのリモートログイン許可:Yes
```bash
Disallow root login remotely? (Press y|Y for Yes, any other key for No) :
```

### テスト用のデータベースの削除:Yes
```bash
Remove test database and access to it? (Press y|Y for Yes, any other key for No) :
```

### 特権情報のリロード:YES
```bash
Reload privilege tables now? (Press y|Y for Yes, any other key for No) :
```

rootでログインしてから実行
### パスワードポリシーの変更
SET GLOBAL validate_password_length=4;
SET GLOBAL validate_password_policy=LOW;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
