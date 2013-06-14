@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


a = @infile.gets().to_i

@outfile.puts "#{2**a % 1000000}"


@infile.close
@outfile.close