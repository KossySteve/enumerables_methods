public
def my_inject(initial = 0, opr = nil)
  k = self
  obj = []
  k.each { |i| obj << i }
  if initial.class == Symbol
    opr = initial.to_s
    (obj.size - 1).times do |i|
      obj[i.next] = obj[i].send(opr, obj[i.next])
      initial = obj[i.next]
    end
  elsif opr.class == Symbol
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
puts multiply_els([2,3,4])
