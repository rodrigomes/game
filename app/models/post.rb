class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :number

  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }

  after_create :generate_new_number

  private

  def generate_new_number
    debugger
    @old_number = self.number

    if @old_number.empty? then
      @number = Post.all[Post.count-2].number
      @number2 = next_number(@number)
      self.update_attribute(:number, @number2)
    else
      if valid_number(@old_number) then
      else
        @number = Post.all[Post.count-2].number
        @number2 = next_number(@number)
        self.update_attribute(:number, @number2)
      end
    end
  end

  def next_number(number)
    number2 = add_one_to(number)

    if valid_number(number2) then
    else
      number2 = next_number(number2)
    end
    number2
  end

  def add_one_to(number)
    numbers = calculate_number(number)

    numbers[5] = numbers[5] + 1
    if numbers[5] == 61 then
      numbers[5] = 1
      numbers[4] = numbers[4] + 1
    end
    if numbers[4] == 61 then
      numbers[4] = 1
      numbers[3] = numbers[3] + 1
    end
    if numbers[3] == 61 then
      numbers[3] = 1
      numbers[2] = numbers[2] + 1
    end
    if numbers[2] == 61 then
      numbers[2] = 1
      numbers[1] = numbers[1] + 1
    end
    if numbers[1] == 61 then
      numbers[1] = 1
      numbers[0] = numbers[0] + 1
    end
    if numbers[0] == 61 then
      numbers[0] = 1
      numbers[1] = 2
      numbers[2] = 3
      numbers[3] = 4
      numbers[4] = 5
      numbers[5] = 6
    end

    number2 = numbers[5]+numbers[4]*100+numbers[3]*10000+numbers[2]*1000000+numbers[1]*100000000+numbers[0]*10000000000
  end

  def valid_number(number2)
    numbers2 = calculate_number(number2)

    @valid = true
    #check uniqueness in db later

    #check different numbers n1 n2 n3 n4 n5 n6
    unless numbers2.uniq.length == numbers2.length
      @valid = false
    end

    @valid
  end

  def calculate_number(number)
    number = number.to_i
    n6 = number % 100
    n5 = number/100 % 100
    n4 = number/100/100 % 100
    n3 = number/100/100/100 % 100
    n2 = number/100/100/100/100 % 100
    n1 = number/100/100/100/100/100 % 100
    [n1,n2,n3,n4,n5,n6]
  end
end
