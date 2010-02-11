class Log

  attr_reader :entries

  def initialize io
    @entries = Array.new
    parse io
  end

  private

  def parse io
    io.each_line do
    end
  end

end
