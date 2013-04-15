@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


symbols = @infile.gets().tr('^[A-Z] ', '').split
n = @infile.gets().to_i

a = Array.new(symbols.length){ |index| index }
result = []
n.times do |i|
  result = result.concat(a.repeated_permutation(i + 1).to_a)
end
result.sort! 
result = result.collect do |x| 
  x.map{|i| symbols[i]}
end
result.each {|p| 
  @outfile.puts p.join ""
}
@infile.close
@outfile.close