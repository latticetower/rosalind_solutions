@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

str = @infile.gets()
elements = str.scan(/[AGCT]/)
a_counter = 0
g_counter = 0
c_counter = 0
t_counter = 0

elements.each do |el|
	case el 
	when 'A' 
		a_counter = a_counter.succ
	when 'G'
		g_counter = g_counter.succ
	when 'C'
		c_counter = c_counter.succ
	when 'T'
		t_counter = t_counter.succ
	end	
end
@outfile.puts("#{a_counter} #{c_counter} #{g_counter} #{t_counter}")

@infile.close
@outfile.close