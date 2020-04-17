module Enumerable
  def my_each
    return to_enum unless block_given?

    array = self
    array.size.times { |i| yield array[i] }
    array
  end

  def my_inject(initial = 0, opr = nil)
    obj = self
    if initial.class == (Symbol or String)
      opr = initial.to_s
      (obj.size - 1).times do |i|
        obj[i.next] = obj[i].send(opr, obj[i.next])
        initial = obj[i.next]
      end
    elsif opr.class == (Symbol or String)
      obj.size.times { |i| initial = initial.send(opr.to_s, obj[i]) }
    elsif initial != 0
      obj.size.times { |i| initial = yield(initial, obj[i]) }
    else
      (obj.size - 1).times do |i|
        obj[i.next] = yield(obj[i], obj[i.next])
        initial = obj[i.next]
      end
    end
    initial
  end

  def multiply_els(obj)
    obj.my_inject { |total, item| total * item }
  end

  def my_map(&proc)
    return to_enum unless block_given?

    my_map_array = []
    obj = self
    if block_given?
      obj.my_each do |i|
        item = yield(i)
        my_map_array << item
      end
    else
      obj.my_each do |i|
        item = proc.call(i)
        my_map_array << item
      end
    end
    my_map_array
  end
end
