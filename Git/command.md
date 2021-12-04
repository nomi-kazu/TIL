- commitで行われた差分の確認(+が付いている行が追加されたところ)<br>
`$ git log -p`<br>

- commitで行われた差分の確認(特定のファイルだけ)<br>
`$ git log -p 差分を確認したいファイル名`<br>

- 差分の確認(ワーキングツリーとステージング領域の差分)<br>
`$ git diff`<br>

- 最新のcommit(前回のcommit:HEAD)との差分確認<br>
  - git commitをする前に、commitの内容が意図したものかどうかを差分を見て確認する<br>
`$ git diff HEAD`<br>

- commitの取り消し<br>
  - revert(特定のコミットを打ち消す)<br>
    - 取り消したいコミットを打ち消すコミットを新しく作成する事により、特定のコミットに戻す。<br>
    - コミットを取り消したという記録が残る。<br>
    -  リモートリポジトリで変更しているものでは原則必須(resetは使わない)。<br>
  - reset(コミット自体をなかった事にする)<br>
    - コミットログを綺麗にできる。<br>
    - 誤操作した時の影響が大きいので取り扱い注意。<br>
    - ローカルリポジトリだけのコミットを削除する場合に利用する事がある。<br>

```
$ git revert 取り消したいcommitハッシュ(ハッシュでなくともHEADでもOK)
vimが立ち上がるので:wqで終了
```

```
$ git reset --hard 戻したいところのcommitハッシュ
```

- 1つ前に選択していたブランチに切り替える<br>
`$ git checkout -`<br>

- リモートリポジトリブランチ一覧表示<br>
`$ git branch --remote`<br>

- リモート、ローカル全てのブランチ一覧表示<br>
`$ git branch -a`<br>

- masterブランチへマージ<br>
  - --no-ff:ブランチからマージされた事の履歴を残す。<br>
`$ git maerge --no-ff マージするブランチ名`<br>

- commitグラフを表示させてブランチの変更履歴を視覚的に確認する<br>
`$ git log --graph`<br>

- 直前のコミットメッセージの修正<br>
`$ git commit --amend -m "修正後のコメント"`<br>

- リモートリポジトリから最新情報をローカルリポジトリに持ってくる(fetchをしてもファイルが更新される訳ではない)<br>
`$ git getch origin`<br>

- リモートリポジトリとの差分確認<br>
`$ git diff origin/master`<br>
