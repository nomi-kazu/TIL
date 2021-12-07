# DOM(Document Object Model)操作
- Webサイトを動的に書き換える技術<br>
- JavaScriptで記述されたプログラムから、HTMLページにアクセスして、XMLページを操作する方法を提供している。<br><br>

# DOMツリー
- HTMLドキュメントやXMLドキュメントをツリー構造として表現したもの。<br><br>

# ノード
- 文章を構成する要素、属性、テキストといったオブジェクト。DOMツリーの1つ1つのオブジェクト。<br>
  - 要素ノード<br>
  - 属性ノード<br>
  - テキストノード<br><br>
  

# getElementByldメソッド
- 指定したidを持つ要素を1つ取得する。(指定したidをもつ要素がなければnullを返す)<br>
`document.ElementByld(id)`<br>

# getElementByTagNameメソッド
- 指定したタグ名を持つ要素を取得するメソッド<br>
- 戻り値は、HTMLCollection(配列と似た構造のデータ)。指定したタグ名が存在しない場合は、空のHTMLCollection([])を返す(nullではないのに注意)。<br>
- tagName:取得したい要素のタグ名<br>
`document.getElementByTagName(tagName)`<br>

# getElementsByNameメソッド
- 指定したname属性を持つ要素を取得するメソッド<br>
- ラジオボタン、チェックボックスなどname属性が等しい要素群の取得に利用。<br>
- 戻り値は、HTMLCollection(配列と似た構造のデータ)。指定したname属性が存在しない場合は、空のHTMLCollection([])を返す(nullではないのに注意)。<br>
`document.getElementsByName(name)`<br>

# getElementsByClassメソッド
- 指定したclass属性を持つ要素を取得するメソッド<br>
- 戻り値は、HTMLCollection(配列と似た構造のデータ)。指定したclass属性が存在しない場合は、空のHTMLCollection([])を返す(nullではないのに注意)。<br>
- name:class属性の値<br>
`document.getElementsByClassName(name)`<br>

# createElementメソッド
- 要素を作成する。<br>
- ノードを作成するだけのため、別途階層に追加する処理が必要。<br>
- name:要素名<br>
`document.createElement(name)`<br>

# createTextNodeメソッド
- テキストノードを作成する。<br>
- ノードを作成するだけのため、別途階層に追加する処理が必要。<br>
`document.createTextNode(text)`<br>

# appendChildメソッド
- 指定された要素を現在の要素の最後の子要素として追加。<br>
- 戻り値は、追加した子ノード<br>
- element:要素オブジェクト、node:追加する子ノード<br>
`element.appendChild(node)`<br>

# replaceChildメソッド
- newChildと、oldChildを入れ替える動作。(appendChildと、removeChildを同時に行う)<br>
- replaceNode:置き換え対象の親ノード<br>
- newChild:置き換え後のノード<br>
- oldChild:置き換え対象のノード<br>
- replaceNode:置き換えられたノード<br>
`replaceNode - parentNode.replaceChild(newChild, oldChild)`<br>

# removeChildメソッド
- 指定した子ノードを取り除く。 取り除いたノードoldChildは、再利用できる。<br>
- child:DOMから取り除く子ノード<br>
- newChild:置き換え後のノードの参照<br>
- oldChild:取り除かれた子ノードの参照<br>
`oldChild = element.removeChild(child)`<br>