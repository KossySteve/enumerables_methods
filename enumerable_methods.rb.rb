module Enumerable
  def my_each
    self.length.times { |i| yield self[i] }
    self
  end

  def my_each_with_index
    self.length.times { |i| yield self[i], i }
  end

  def my_select
    my_select_array = []
    for item in self
      my_select_array << item if yield(item)
    end
    my_select_array
  end

  def my_all?
    i = 0
    all = true
    while i < self.length
      unless yield(self[i])
        all = false
        break
      end
      i += 1
    end
    all
  end
print [2,4,5].my_all?{|num| num%2==0 }
  def my_any?
    i = 0
    any_item = false
    while i < self.length
      if yield(self[i])
        any_item = true
        break
      end
      i += 1
    end
    any_item
  end

  def my_none?
    i = 0
    no_item = true
    while i < self.length
      if yield (self[i])
        no_item = false
        break
      end
      i += 1
    end
    no_item
  end

  def my_count
    i = 0
    self.my_each { |item| i += 1 if yield(item) }
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
  #my_proc = Proc.new {|num| num * 2}
  #puts [2,3,4].my_map(&my_proc)
end
