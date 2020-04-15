#module Enumerable

#end
public
def my_each
    i = 0
    n = self.size
  while i < n
    yield(self[i])
    i += 1
  end
  self
end

#[2,3,41,2,24].my_each {|num| print num * 2}
def my_each_with_index
      i = 0
      n = self.size
    while i < n
      yield(self[i],i)
      i += 1
    end
    self
end

#[2,3,41,2,24].my_each_with_index {|num, index| print index}


def my_select
    my_select_array = []
    for item in self
        if yield (item)
        my_select_array << item
        end
    end
    return my_select_array
end

#puts ""
#print [1,2,3,4,5,6,7,8,100].my_select {|num| num%2 == 0}

def my_all?
    i = 0
    all = true
  while i < self.size
      if self[i] % 2 != 0
        all = 
        break
      end
      i+=1
  end
  print all
end
puts [1,3,5,7].my_all?

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
#puts [1,3,2,5,7]. my_any?{|x| x%2 == 0}

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
#puts [1,3,5,7].my_none?{|x| x%2 == 0}
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
#puts [1,3,4,5,7,2].my_count{ |x| x%2 == 0 }

def my_map
    my_map_array = []
    for item in self
    item =  yield (item)
    my_map_array << item
    end
    return my_map_array
end
#print [1,3,100,5,7,2].my_map
def my_inject

  i = 0
  injected = 0
  n = self.size - 1
    n.times { |i|
      self[i+1] = yield(self[i] , self[i.next])
      injected = self[i+1]
      i+=1
    }
    print injected
end
#puts [2,4,5].my_inject
#puts [2,4,5].my_inject {|total, num| total / num}

def my_map_with_proc
    my_map_array = []
    for item in self
    item =  yield (item)
    my_map_array << item
    end
    return my_map_array
end
#print [1,3,100,5,7,2].my_map
