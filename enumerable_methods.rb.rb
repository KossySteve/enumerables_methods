module Enumerable
  def my_each
    i = 0
    n = self.size
    while i < n
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    n = self.size
    while i < n
      yield(self[i],i)
      i += 1
    end
    self
  end

  def my_select
    my_select_array = []
    for item in self
      if yield (item)
        my_select_array << item
      end
    end
    return my_select_array
   end

  def my_all?
    i = 0
    all = true
    while i < self.size
      unless yield(self[i])
      all = false
      break
      end
    i+=1
    end
    print all
  end


  def my_any?
    i = 0
    any_item = false
    while i < self.size
      if yield(self[i])
        any_item = true
        break
      end
      i+=1
    end
  print any_item
end

  def my_none?
    i = 0
    no_item = true
    while i < self.size
      if yield (self[i])
        no_item = false
        break
      end
      i+=1
    end
    print no_item
  end

  def my_count
    i = 0
    self.my_each {
      |item|
      if yield(item)
        i+=1
      end
    }
    print i
  end

  def my_inject
    i = 0
    injected = 0
    n = self.size - 1
    n.times { |i|
      self[i+1] = yield(self[i] , self[i.next])
      injected = self[i+1]
      i+=1
    }
    injected
  end

  def multiply_els(array)
    array.my_inject {|total, item| total * item}
  end

  def my_map
    my_map_array = []
    for item in self
      item =  yield(item)
      my_map_array << item
    end
    return my_map_array
  end


  def my_map(&proc)
    my_map_array = []
    for item in self
      item =  proc.call(item)
      my_map_array << item
    end
    return my_map_array
  end

  def my_map(&proc)
    my_map_array = []
    if block_given?
      for item in self
        item =  yield (item)
        my_map_array << item
      end
    else
      for item in self
        item =  proc.call(item)
        my_map_array << item
      end
    end
    return my_map_array
  end
  
end
