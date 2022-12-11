class Item
  attr_accessor :worry, :monkey
  @@all = []
  
  def initialize(worry, monkey)
    @worry     = worry
    @monkey    = monkey

    @@all << self
  end
end

class Monkey
  attr_accessor :items, :operation, :test, :if_true, :if_false, :business
  @@all = []

  def initialize(operation, test, if_true, if_false)
    @items = []
    @operation = operation.split.drop(1).join(" ")
    @test      = test.split.last.to_i
    @if_true   = if_true.split[5].to_i
    @if_false  = if_false.split[5].to_i
    @business  = 0

    @@all << self
  end

  def new_item(worry)
    item = Item.new(worry, self)
    self.items << item
  end

  def inspect_items
    self.items.each do |item|
      old = item.worry
      new = 0
      eval(self.operation)
      # item.worry = new / 3 # Part 1
      item.worry = new # Part 2

      if item.worry > Worry_cap
        item.worry = item.worry % Worry_cap
      end

      if item.worry % self.test == 0
        target = Monkey.all[self.if_true]
      else
        target = Monkey.all[self.if_false]
      end

      item.monkey = target
      target.items << item
      self.business = self.business + 1
    end
    self.items = []
  end

  def self.all
    @@all
  end
end

input = $stdin.read.lines(chomp: true)

((input.count / 7) + 1).times do |i|
  monkey = Monkey.new(
    input[(i * 7) + 2], input[(i * 7) + 3],
    input[(i * 7) + 4], input[(i * 7) + 5]
  )
  input[(i * 7) + 1].split.drop(2).each do |a|
    monkey.new_item(a.to_i)
  end
end

Worry_cap = Monkey.all.map { |m| m.test }.inject(:*)

10000.times do |i| # Run 20 cycles for part 1, 10000 cycles for part 2
  Monkey.all.each do |monkey|
    monkey.inspect_items
  end
end

two_busiest_monkeys = Monkey.all.sort_by { |m| m.business }.reverse.take(2)
puts two_busiest_monkeys[0].business * two_busiest_monkeys[1].business
