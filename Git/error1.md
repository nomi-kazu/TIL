# git pushコマンドを実行すると『Everything up-to-date』と返されてしまった

- 『Everything up-to-date』とは『最新の状態；ローカルブランチの内容とリモートブランチの内容に差分が無い』
- 原因は、commitのし忘れであったので、commitを行い解決。

- `git fetch --all`　→　`git branch -avv` の順で実行すると、ローカルブランチとリモートブランチのコミットIDを見ることができる。
→　コミットIDが同じだった場合は、単にコミットのし忘れということになる。