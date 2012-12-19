@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

str = @infile.gets()
@outfile.puts(str.gsub(/T/, 'U'))

@infile.close
@outfile.close