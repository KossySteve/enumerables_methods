module Enumerable
  def my_each
    return to_enum unless block_given?
    array = self
    array.size.times { |i| yield array[i] }
    array
  end

  def my_each_with_index
    return to_enum unless block_given?
    array = self
    array.length.times { |i| yield array[i], i }
    array
  end

  def my_select
    return to_enum unless block_given?
    array = self
    my_select_array = []
    array.my_each { |item| my_select_array << item if yield(item) }
    my_select_array
  end

  def my_all?(pattern = nil)
    obj = self
    all = true
    if pattern != nil
      obj.each { |i| all = false unless pattern === i }
    elsif !block_given?
      obj.each { |i| all = false if (i == false or i == nil)}
    else
      obj.each { |i| all = false unless yield i}
    end
    return all
  end

  def my_any?(pattern = nil)
    obj = self
    any_item = false
    if pattern != nil
      obj.my_each { |i| any_item = true if pattern === i }
    elsif !block_given?
      obj.my_each { |i| any_item = true unless (i == false or i == nil)}
    else
      obj.my_each { |i|any_item = true if yield i }
    end
    return any_item
  end

  def my_none?(pattern = nil)
    obj = self
    none = true
    if pattern != nil
      obj.my_each { |i| none = false if pattern === i }
    elsif !block_given?
      obj.my_each { |i| none = false unless (i == false or i == nil)}
    else
      obj.my_each { |i| none = false if yield i }
    end
    return none
  end

  def my_count(item = nil)
    obj = self
    counter = 0
    if item != nil
      obj.my_each { |i| counter += 1 if item == i }
    elsif !block_given?
      obj.my_each { |i| counter += 1}
    else
      obj.my_each { |item| counter += 1 if yield(item) }
    end
    return counter
  end

  def my_inject(initial = 0, op =nil)
    obj = self
    if initial.class == (Symbol or String)
      op = initial.to_s
      (obj.size - 1).times do |i|
        self[i.next] = self[i].send(op, self[i.next])
        initial = self[i.next]
      end
    elsif op.class == (Symbol or String)
      obj.size.times do |i|
        initial = initial.send(op.to_s, self[i])
      end
    elsif initial != 0
      obj.size.times do |i|
        initial = yield(initial, self[i])
      end
    else
      (obj.size - 1).times do |i|
        self[i.next] = yield(self[i], self[i.next])
        initial = self[i.next]
      end
    end
    return initial
  end
=begin
  def multiply_els(obj)
    obj.my_inject { |total, item| total * item }
  end
  multiply_els([2, 3, 4])
  #puts [2, 3, 4].my_inject { |total, item| total * item }

  def my_map(&proc)
    my_map_array = []
    array = self
    if block_given?
      array.my_each do
        item = yield(item)
        my_map_array << item
      end
    else
      array.my_each do
        item = proc.call(item)
        my_map_array << item
      end
    end
    my_map_array
  end
=end
end
