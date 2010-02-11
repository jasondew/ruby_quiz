class Format

  class Field

    attr_reader :name, :type, :type_length, :description

    def initialize(name, type, type_length, description)
      @name, @type, @type_length, @description = name, type, type_length, description
    end

  end

  def self.read(filename)
    format = Array.new

    File.read(filename).each do |line|
      next if line =~ /^#/
      format << read_line(line)
    end

    format
  end

  private

  def self.read_line(line)
    name, type, type_length, description = line.split(" ", 4)
    Field.new(name, type, type_length, description)
  end

end
