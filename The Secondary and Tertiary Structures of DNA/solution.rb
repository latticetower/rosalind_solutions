@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')
repl = {'A' => 'T', 'T' => 'A', 'G' => 'C', 'C' => 'G'}
str = @infile.gets()
@outfile.puts(str.scan(/[AGCT]/).map{|x| repl[x] }.reverse.join)

@infile.close
@outfile.close