@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


symbols = @infile.gets().tr('^[A-Z] ', '').split
n = @infile.gets().to_i

a = Array.new(symbols.length){ |index| symbols[index] }

a.repeated_permutation(n) {|p| 
  @outfile.puts p.join ""
}
@infile.close
@outfile.close