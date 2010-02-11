#!/usr/bin/ruby -w

require 'lib/format'
require 'lib/datum'
require 'pp'

FORMAT_FILENAME = "abbrev_format.txt"
DATA_FILENAME = "database/ABBREV.txt"

fields = Format.read( FORMAT_FILENAME )

def field_value(datum, field)
  case field.type
    when 'N': (field.type_length =~ /\./) ? datum.to_f : datum.to_i
    when 'A': (datum =~ /^~([^~]*)~$/) and $1
  end
end

def convert(data, fields)
  datum = Datum.new

  data.zip(fields).collect do |(source, field)|
    datum.send("#{field.name}=", field_value(source, field))
  end

  datum
end

data = Array.new

File.open(DATA_FILENAME) do |f|
  f.each {|line| data << convert(line.chomp.split("^"), fields) }
end

File.open("abbrev.db", "wb") do |f|
  f.write Marshal.dump(data)
end
