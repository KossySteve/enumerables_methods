module Enumerable
  def my_each
    array = self
    array.size.times { |i| yield array[i] }
    array
  end

  def my_each_with_index
    array = self
    array.length.times { |i| yield array[i], i }
    array
  end

  def my_select
    array = self
    my_select_array = []
    array.my_each { |item| my_select_array << item if yield(item) }
    my_select_array
  end

  def my_all?
    array = self
    i = 0
    all = true
    while i < array.length
      unless yield(array[i])
        all = false
        break
      end
      i += 1
    end
    all
  end

  def my_any?
    array = self
    i = 0
    any_item = false
    while i < array.length
      if yield(array[i])
        any_item = true
        break
      end
      i += 1
    end
    any_item
  end

  def my_none?
    array = self
    i = 0
    no_item = true
    while i < array.length
      if yield (array[i])
        no_item = false
        break
      end
      i += 1
    end
    no_item
  end

  def my_count
    array = self
    i = 0
    array.my_each { |item| i += 1 if yield(item) }
    i
  end

  def my_inject
    array = self
    injected = 0
    (array.size - 1).times do |i|
      self[i + 1] = yield(self[i], self[i.next])
      injected = self[i + 1]
    end
    injected
  end

  def multiply_els(array)
    array.my_inject { |total, item| total * item }
  end

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
end
