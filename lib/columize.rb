#
# Columize
# originally by Courtenay
# http://blog.caboo.se/articles/2006/06/10/pretty-tables-for-ruby-objects
#

class Object
  def opp(arr, fields=nil, options={})
    if arr.size > 0 and arr[0].is_a?ActiveRecord::Base
      fields ||= arr[0].class.content_columns.map(&:name)
    end
    puts arr.pretty_table(fields, options)
  end
end

class Array
  protected
    def pretty_table_row(fields, sizes, obj = nil)
      ret = []
      fields.each_with_index do |field,i|
        ret << sprintf("%0-#{sizes[i]}s", (obj ? obj[field] : field).to_s.first(sizes[i]) )
      end
      ret = '| ' + ret.join(' | ') + ' |'
    end

  public

    # usage:
    # @some_array.pretty_table([:id, :login, :email], {
    #    :max_width => 5,
    #    :line_spacer => '-',
    #    :find => { :conditions => ['activated=?',true] }
    #  })
    def pretty_table(fields, options = {})
      sizes = [0] * fields.size # set up a nice empty array

      # determine the longest string in each column
      self.each do |ar|
        fields.each_with_index do |f,i|
          sizes[i] = [sizes[i], ar.send(f).to_s.size].max
          sizes[i] = [ options[:max_width].to_i, sizes[i] ].min if options[:max_width]
        end
      end

      ret = []
      ret << header = pretty_table_row(fields, sizes)
      ret << header.gsub(/./, options[:line_spacer] || '=')

      self.each do |ar|
        ret << pretty_table_row(fields, sizes, ar)
      end
      ret.join("\n")
    end
end

class ActiveRecord::Base
  class << self
    # usage:
    # User.pretty_table([:id, :login, :email], {
    #    :max_width => 5,
    #    :line_spacer => '-',
    #    :find => { :conditions => ['activated=?',true] }
    #  })
    # All args are optional

    def pretty_table(fields = nil, options = {})
      fields ||= self.content_columns.map(&:name)
      sizes = [0] * fields.size # set up a nice empty array
      all = find(:all, options[:find])
      all.pretty_table(fields, options)
    end
  end
end
