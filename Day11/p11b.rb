#frozen_string_literal: true

# For the record, I am not proud of any of this.
# It's gross and I don't even understand it.

INPUT_FILE = 'input.txt'

monkeys_file = File.open(INPUT_FILE)
monkey_data = monkeys_file.readlines.map(&:chomp)

class Monkey
  attr_accessor :items, :op_operand, :op_value, :items_inspected,
                :divisible_by, :throws_to_on_true, :throws_to_on_false

  def initialize(id)
    monkey_id = id

    @items_inspected = 0

    @items = nil
    @op_operand = nil
    @op_value = nil
    @divisible_by = nil
    @throws_to_on_true = nil
    @throws_to_on_false = nil
  end

  def drop_item
    @items = @items.drop(1)
  end

  def display
    puts "Items Inspected: #{items_inspected}"
    puts "Starting Items: #{items}"
    puts "Operand: #{op_operand}"
    puts "Operation Value: #{op_value}"
    puts "Divisble By: #{divisible_by}"
    puts "Throw to on True: #{throws_to_on_true}"
    puts "Throw to on False: #{throws_to_on_false}"
    puts "\n"
  end
end

monkeys = []
current_monkey = nil

monkey_data.each do |line|
  
  if line.split(' ')[0] == 'Monkey'
    current_monkey = Monkey.new(line.split[1][0])
  elsif line[0..16] == ('  Starting items:')
    items = line.split('Starting items: ')[1].split(', ')

    current_monkey.items = items
  elsif line[0..11] == '  Operation:'
    current_monkey.op_operand = line.split('  Operation: ')[1].split(' ')[-2]
    current_monkey.op_value = line.split('  Operation: ')[1].split(' ')[-1].to_i
  elsif line[0..6] == '  Test:'
    current_monkey.divisible_by = line.split('  Test:')[1].split(' ')[-1].to_i
  elsif line[0..11] == '    If true:'
    id = line.split('    If true:')[1].split(' ')[-1]

    current_monkey.throws_to_on_true = id.to_i
  elsif line[0..12] == '    If false:'
    id = line.split('    If false:')[1].split(' ')[-1]

    current_monkey.throws_to_on_false = id.to_i
    
    monkeys << current_monkey

    current_monkey = nil
  end
end

worry_level = 0

supermodulo = monkeys.map { |x| x.divisible_by }.inject(:*)

(0..9999).each do |round|
  monkeys.each do |monkey|
    monkey.items_inspected += monkey.items.length

    monkey.items.each do |item|
      case monkey.op_operand
      when '+'
        worry_level = (item.to_i + monkey.op_value)
      when '*'
        if monkey.op_value == 0
          worry_level = (item.to_i * item.to_i)
        else
          worry_level = (item.to_i * monkey.op_value)
        end
      end

      worry_level = worry_level % supermodulo

      if (worry_level % monkey.divisible_by) == 0
        monkeys[monkey.throws_to_on_true].items << worry_level.to_i
      else
        monkeys[monkey.throws_to_on_false].items << worry_level.to_i
      end

      worry_level = 0
      monkey.drop_item
    end
  end
end

monkeys = monkeys.sort_by { |x| x.items_inspected }.reverse

puts monkeys[0].items_inspected * monkeys[1].items_inspected