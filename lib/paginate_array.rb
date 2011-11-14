class PaginateArray < Array
  def self.paginates_per num
    STDERR.puts "PaginateArray.paginates_per #{num.inspect}"
    @@paginates_per = num
  end

  attr_reader :current_page
  
  def initialize array=[], origin_size = nil
    @current_page = 1
    @paginates_per = @@paginates_per || 10
    @origin_size = origin_size
    STDERR.puts "PaginateArray.new(#{array.inspect}) @paginates_per #{@paginates_per}"
    super array
    self
  end

  def page num=1
    num = (num||1).to_i
    STDERR.puts "PaginateArray#page(#{num}) => [#{((num-1)*@paginates_per)}...#{(num*@paginates_per)}]"
    PaginateArray.new(self[((num-1)*@paginates_per)...(num*@paginates_per)], self.size)
  end

  def num_pages
    STDERR.puts "#{self.inspect}.num_pages"
    STDERR.puts "self.size #{self.size}"
    STDERR.puts "@paginates_per #{@paginates_per}"
    s = @origin_size || self.size
    s / @paginates_per + (((s % @paginates_per) > 0) ? 1 : 0)
  end

  def limit_value
    @paginates_per
  end
end
