@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

s = @infile.gets().strip
t = @infile.gets().strip
@res = []
@ind = 0
@ind = s.index(t, @ind) 
while not @ind.nil?
  puts @ind
  @ind = @ind + 1
  @res << @ind
  @ind = s.index(t, @ind)
end

@outfile.puts("#{@res.join(' ')}")

@infile.close
@outfile.close