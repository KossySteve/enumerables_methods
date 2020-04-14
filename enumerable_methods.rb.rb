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

[2,3,41,2,24].my_each_with_index {|num, index| print index}


def my_select
    my_select_array = []
    for item in self
        if yield (item)
        my_select_array << item
        end
    end
    return my_select_array
end

puts ""
print [1,2,3,4,5,6,7,8,100].my_select {|num| num%2 == 0}

def my_all?
    i = 0
    all = true
  while i < self.size
      if self[i] % 2 != 0
        all = false
        break
      end
      i+=1
  end
  print all
end
puts ""

def my_any?
    i = 0
    any_item = false
  while i < self.size
      if self[i] % 2 == 0
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
      if self[i] % 2 == 0
        no_item = false
        break
      end
      i+=1
  end
  print no_item
end
puts [1,3,5,7,2].my_none?
