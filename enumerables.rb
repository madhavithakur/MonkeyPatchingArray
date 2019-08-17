require 'byebug'
class Array 

  def my_each(&prc)   #[1,2,3]
    debugger
    i = 0 
    while i < self.length 
      prc.call(self[i])
      i += 1 
    end 
  end 

    # def my_select(&prc)
    #   output = []
    #   i = 0
    #   while i < self.length
    #     output << self[i] if prc.call(self[i])
    #     i += 1
    #  end
    #  output
    #  end

    def my_select(&prc)
      output = []
      debugger
      self.my_each {|ele| output << ele if prc.call(ele)}
      output
    end

    def my_reject(&prc)
      output = []
      self.my_each {|ele| output << ele if !prc.call(ele)}
      output
    end

    def my_any?(&prc)
      self.my_each {|ele| return true if prc.call(ele)}
      false 
    end 

    def my_all?(&prc)
      self.my_each {|ele| return false if !prc.call(ele)}
      true
    end

    def my_flatten
      #  return [self] if !self.is_a?(Array)  # [1] + [2] + [3] + [4] + [5] +[6] => 
       flatten = []
       self.my_each do |ele| 
        if !ele.is_a?(Array) 
          flatten << ele 
        else 
          flatten += ele.my_flatten # if the element is an array, recursively call the my_flatten method on the element and add it to flatten 
        end 
      end  
      flatten 
    end 

    def my_zip(*arrays)
      output = []
      i = 0 
      self.my_each do |ele|
        sub = [ele]
        arrays.my_each {|array| sub << array[i]}
        output << sub
        i += 1
      end
      output
    end

    def my_rotate(num = 1) # need to make duplicate 
      output = self.dup # duplicates the original array 
      num.abs.times do 
        # debugger
        if num > 0
          output.push(output.shift) 
        else
          output.unshift(output.pop)
        end
      end 
      output
    end 

    # def my_join(sep = "")  ## alternative way to iterate over indices 
    #   str = ""
    #   (0...self.length).to_a.my_each do |i| # ask TA
    #     # debugger
    #     if i == self.length - 1
    #       str += self[i] 
    #     else
    #       str += self[i] + sep
    #     end
    #   end 
    #     str
    #   end 

    def my_join(sep = "")
      str = ""
      i = 0 
      self.my_each {|ele| str += (ele+sep)}
      # while i < self.length 
      #   if i == self.length - 1 
      #     str += self[i]
      #   else 
      #     str += self[i] + sep 
      #   end 
      #   i += 1 
      # end 
      str[0...-1]
    end 

      def my_reverse
        output = []
        self.my_each {|ele| output.unshift(ele)}
        # output = []
        # i = self.length - 1
        # while i >= 0
        #   output << self[i]
        #   i -= 1
        # end  
         output
      end   
    
  
end 

p ["a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [1].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"] 
# p a.my_rotate(-3)     #=> ...                                  ] # 
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

arr = Array.new([1,2,3])
puts arr.my_each {|num| num }
 
p arr.my_select { |num| num > 1 } # => [2, 3]
# p arr.my_reject { |num| num > 1 } # => [2, 3]
# p arr.my_any? { |num| num > 1 }
# p arr.my_any? { |num| num == 4 }
# p arr.my_all? {|num| num > 1}
# p arr.my_all? {|num| num < 4 }

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten 
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"


