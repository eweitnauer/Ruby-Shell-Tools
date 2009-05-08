require 'ftools'
require 'tempfile'

if ARGV.size != 4
  puts "adds gplv3 licence note to code files"
  puts "usage: ruby add_gpl.rb <file-pattern> <comment-char> <copyright> <program name>"
  puts "example: for recursively add gpl note to all .cpp and .h files call"
  puts "         ruby add_gpl '**/*.{cpp,h}' '//' 'Copyright 2009 Erik Weitnauer' 'add_gpl3'"
  exit
end

pattern = ARGV[0]
cc = ARGV[1]
copyright = ARGV[2]
gpl3_text = "#{cc} This file is part of #{ARGV[3]}.
#{cc}
#{cc} #{ARGV[3]} is free software: you can redistribute it and/or modify
#{cc} it under the terms of the GNU General Public License as published by
#{cc} the Free Software Foundation, either version 3 of the License, or
#{cc} (at your option) any later version.
#{cc}
#{cc} #{ARGV[3]} is distributed in the hope that it will be useful,
#{cc} but WITHOUT ANY WARRANTY; without even the implied warranty of
#{cc} MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#{cc} GNU General Public License for more details.
#{cc}
#{cc} You should have received a copy of the GNU General Public License
#{cc} along with #{ARGV[3]}.  If not, see <http://www.gnu.org/licenses/>."

Dir[pattern].each do |filename|
  next unless File.file? filename
	print "processing #{filename} ... "
	temp = Tempfile.new("add_gpl")
	temp.puts "#{cc} #{copyright}"
	temp.puts "#{cc}"
	temp.puts gpl3_text
	File.foreach(filename) do |line|
  	temp << line
	end
  temp.close
  File.move(temp.path, filename)
	puts "OK"
end
