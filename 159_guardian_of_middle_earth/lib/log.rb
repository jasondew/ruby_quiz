class Log

  class Entry
  
    attr_reader :mob, :style, :damage, :type
  
    def initialize data
      @data = data
  
      case @data.size
        when 3: initialize_without_style
        when 4: initialize_with_style
      end
  
      @damage = @damage.to_i
    end
  
    private
  
    def initialize_with_style
      @mob, @style, @damage, @type = @data
    end
  
    def initialize_without_style
      @mob, @damage, @type = @data
    end
  
  end

  attr_reader :entries

  def initialize io
    @entries = Array.new
    @offensive_res = [ /You wound the (.*) with (.*) for (.*) points of (.*) damage\.$/,
                       /You wound the (.*) for (.*) points of (.*) damage\.$/ ]
    parse io
  end

  private

  def parse io
    io.each_line do |line|
      next if line.chomp! =~ /^#/
      next unless line =~ /^You wound the/

      @offensive_res.each do |re|
        if result = line.match(re)
          @entries << Entry.new(result.captures)
        end
      end
    end
  end

end
