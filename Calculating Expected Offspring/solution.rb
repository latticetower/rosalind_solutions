@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


a0 = @infile.gets().split
expectedOffspring = 2*a0[0].to_f + 2*a0[1].to_f + 2*a0[2].to_f + 1.5*a0[3].to_f + a0[4].to_f


@outfile.puts("#{expectedOffspring.to_f}")

@infile.close
@outfile.close