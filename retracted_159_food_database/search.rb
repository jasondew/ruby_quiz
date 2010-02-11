require 'lib/format'
require 'lib/datum'
require 'pp'

data = Marshal.load( File.read("abbrev.db") )

pp data.length
pp data.select {|x| x.short_description =~ /PIZZA/i }.collect {|x| x.short_description }
