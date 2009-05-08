require 'ftools'
require 'tempfile'

if ARGV.size != 3
  puts "substitute searches and replaces in files"
  puts "usage: ruby substitute.rb <file-pattern> <reg-exp> <new string>"
  puts "example: for changing 'corect' to 'correct' in all .h or .cpp files use"
  puts "         ruby substitute.rb '*.{h,cpp}' 'corect' 'correct'"
  puts "example: for recursively put all vocals in brackets in all .txt files use"
  puts "         ruby substitute.rb '**/*.txt' '([aeiou])' '<\\1>'"
  exit
end

pattern = ARGV[0]
regexp = Regexp.new(ARGV[1])
replacement = ARGV[2]

Dir[pattern].each do |filename|
  next unless File.file? filename
	print "processing #{filename} ... "
	temp = Tempfile.new("file_sub")
	File.foreach(filename) do |line|
  	temp << line.gsub(regexp,replacement)
	end
  temp.close
  File.move(temp.path, filename)
	puts "OK"
end
