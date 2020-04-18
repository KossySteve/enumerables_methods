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

  def my_all?(pattern = 0)
    obj = self
    all = true
    if block_given?
      obj.my_each { |i| all = false unless yield i }
    elsif !block_given? and pattern.nil?
      obj.my_each { |i| all = false if i == (false || nil) }
    else
      obj.my_each do |i|
        all = false unless i.is_a? (pattern) || pattern =~ i
      end
    end
    all
  end

  def my_any?(pattern = 0)
    obj = self
    any_item = false
    if block_given?
      obj.my_each { |i| any_item = true if yield i }
    elsif !block_given? and pattern.nil?
      obj.my_each { |i| any_item = true unless i == false || i.nil? }
    else
      obj.my_each { |i| any_item = true if i.is_a? (pattern) || pattern =~ i }
    end
    any_item
  end

  def my_none?(pattern = 0)
    obj = self
    none = true
    if !pattern.nil?
      obj.my_each { |i| none = false if i.is_a? (pattern)|| pattern =~ i }
    elsif !block_given?
      obj.my_each { |i| none = false if i == true }
    else
      obj.my_each { |i| none = false if yield i }
    end
    none
  end

  def my_count(item = nil)
    obj = self
    counter = 0
    if !item.nil?
      obj.my_each { |i| counter += 1 if item == i }
    elsif !block_given?
      obj.my_each { counter += 1 }
    else
      obj.my_each { |i| counter += 1 if yield(i) }
    end
    counter
  end

  def my_map
    obj = self
    my_map_array = []
    return to_enum unless block_given?

    obj.my_each do |i|
      item = yield(i)
      my_map_array << item
    end
    my_map_array
  end
end
