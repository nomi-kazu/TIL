class Person
  attr_reader :age, :first_name, :last_name
  attr_writer :first_name, :last_name


  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def full_name
    puts "#{first_name} #{last_name}"
  end

  def info
    puts "#{full_name}(#{age})"
  end

  def rename(first_name, last_name)
    self.first_name = first_name
    self.last_name = last_name
  end
end
