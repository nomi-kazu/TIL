・initializeメソッド：new演算子を使用してインスタンス化する時に呼ばれるメソッド<br>
  →外から呼び出すことはできない（デフォルトでprivateメソッドになってる）<br>
  →initializeメソッド以外のメソッドは外部から自由に呼び出せるメソッド＝publicメソッド<br>
  
```
class User
  def initialize
    puts "Initialize!"
  end
end
user = User.new #=> Initialize!
user.initialize #=> NoMethodError: private method 'initialize' called for #<User:~
```

→initializeメソッドに引数を付けると、newメソッドを呼ぶ時にも引数が必要
```
class User
  def initialize(name, age)
    puts "name: #{name}, age: #{age}"
  end
end
User.new("goma", 20) #=> name: goma, age: 20
```
