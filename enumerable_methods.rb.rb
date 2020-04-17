module Enumerable
  def my_each
    return to_enum unless block_given?
    array = self
    array.size.times { |i| yield array[i] }
    return array
  end

  def my_each_with_index
    return to_enum unless block_given?
    array = self
    array.length.times { |i| yield array[i], i }
    return array
  end

  def my_select
    return to_enum unless block_given?
    array = self
    my_select_array = []
    array.my_each { |item| my_select_array << item if yield(item) }
    return my_select_array
  end

  def my_all?(pattern = nil)
    obj = self
    all = true
    if pattern != nil
      obj.my_each { |i| all = false unless pattern === i }
    elsif !block_given?
      obj.my_each { |i| all = false if (i == false or i == nil)}
    else
      obj.my_each { |i| all = false unless yield i}
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
      (obj.size - 1).times { |i| obj[i.next] = obj[i].send(op, obj[i.next]); initial = obj[i.next] }
    elsif (initial != 0) && (op.class == (Symbol or String))
      obj.size.times { |i| initial = initial.send(op.to_s, obj[i]) }
    elsif initial != 0
      obj.size.times { |i| initial = yield(initial, obj[i]) }
    else
      (obj.size - 1).times { |i| obj[i.next] = yield(obj[i], obj[i.next]); initial = obj[i.next] }
    end
    return initial
  end

  def multiply_els(obj)
    obj.my_inject { |total, item| total * item }
  end

  def my_map
    obj = self
    my_map_array = []
    return to_enum unless block_given?
    obj.my_each { |i| item = yield(i); my_map_array << item}
    return my_map_array
  end

  def my_map(&proc)
    return to_enum unless block_given?
    my_map_array = []
    obj = self
    if block_given?
      obj.my_each { |i| item = yield(i); my_map_array << item}
    else
      obj.my_each { |i| item = proc.call(i); my_map_array << item}
    end
    return my_map_array
  end
end
