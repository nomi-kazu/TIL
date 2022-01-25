# Postgresで発生したエラー「PG::ConnectionBad: 〜"/tmp/.s.PGSQL.5432"?」

- rails s をちゃんと停止せずにスリープ状態のPCがアプデされてしまいエラーが起きた
- 解決法
```
$ brew services start postgresql
でデーターベースを起動させたらエラー解消した
```