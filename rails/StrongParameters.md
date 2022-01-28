# Strong Parameters
・Railsでは、悪意のあるデータが挿入される事を防ぐ為に、きちんとデータの形式を検証しましょうという仕組みになっている。パラメーターを強めにチェックしましょうと言う意味。<br><br>

```
(例)
def create
  @post = Post.new(params[:post])
  @post.save
end

private

def post_params
  # requireメソッドがデータのオブジェクト名を定める
  # permitメソッドで変更を加えられる（保存の処理ができる）キーを指定
  # 送信されてきたデータは、postをキーにしてtitleやbodyのがあるハッシュじゃないといけない
  params.require.(:post).permit(:title, :body)
end
```

<br>
これをあらかじめ設定しておくことで、仮に悪意のあるリクエスト（指定した以外のデータを送ってくる等）を受けた際に、permitメソッドで許可していない項目については変更されず、データの扱いがより安全になる。