@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

def factorial(n)
  return 1 if n == 1
  return 1 if n == 0
  n*factorial(n - 1)
end
n = @infile.gets().to_i

@outfile.puts "#{factorial(n)}"
a = Array.new(n){ |index| index + 1 }
a.permutation do |p|
  @outfile.puts p.join " "
  end
@infile.close
@outfile.close