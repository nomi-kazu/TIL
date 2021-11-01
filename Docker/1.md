# Dockerの基本

教材：https://y-ohgi.com/introduction-docker/

## Docker Image

*環境のスナップショット*の役割を果たす。
~~~
docker run ~
~~~
コマンドで起動できる。imageには様々なものがあり、DockerHubで公開されている。
ローカルにないimageをrunすると、勝手にDockerHubからdocker pullしてローカルに持ってきてくれる。

## Dockerfile

Docker Imageの元、このファイルを基にbuildすることでスナップショットを作成できる。
Dockerfileは独自のDSLで書かれる。
~~~
FROM, COPY, RUN, CMD, WORKDIR, ENV, USER
~~~
などのコマンドをよく使う（詳しくは今度）

ローカルで開発したイメージを本番環境やステージングで使うにはDockerレジストリにアップする必要がある。
レジストリはDocker版のGithubのようなもの、公式はDockerHubだが、AWSやGCPのものもある。
クラウド上に本番環境を作るならそのクラウドが提供しているレジストリのほうが良い。

アップするには
~~~
docker push ~
~~~


## Docker Container

Docker Imageはスナップショット、Containerはそこから起動したプロセス。
Docker Containerは１つのコマンドをフォアグランドで動かすように設計されている。Containerは１つのコマンドを隔離された環境で実行、そのコマンドの実行がフォアグラウンドで終わるまで生存。

## Docker network

Docker Containerは１コンテナ１プロセスが原則。複数のプロセスを協調して使うにはネットワークで通信を行う。
```docker network create ~```
で作成
