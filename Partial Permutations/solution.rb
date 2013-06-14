@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


def p(n,k)
  s = 1
  k.times do |i|
    s = s * (n - i)
  end
  s
end

a = @infile.gets().split
@outfile.puts p(a[0].to_i, a[1].to_i) % 1000000



@infile.close
@outfile.close