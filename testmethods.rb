#[5, 2, 4].my_each{|num| print "#{num}! " }
#[5, 2, 4].my_each_with_index {|num, index| print "#{num} : #{index}, " }
#puts [2,"3",4].all?(Numeric)
#puts ["A","V","E"].my_any?("V")
#puts ["A","V","E"].my_none?(Numeric)
#puts [1, 2, 4, 2].my_count(2)
#puts [5, 2, 4].my_inject(1, :*)
#puts multiply_els([2,3,4])
#print [2,3,4,5].my_map {|num| num * 2}
#my_proc = Proc.new {|num| num * 2}
#print [2,3,4].my_map(&my_proc)
