@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')




def get_distance(newick_str, v1, v2)
  return get_distance(newick_str, v2, v1) if newick_str.index(v1) > newick_str.index(v2)
  s = newick_str[(newick_str.index(v1) + v1.size)..(newick_str.index(v2)-1)].gsub(/[^\(\)\,]*/,'')

  s = s.gsub(/(?:(?<f1>\((?:(?>\\[()]|[^()])|\g<f1>)*\)))/,'')
  puts s
  r = (s.count(',') > 0 ? 2 : 0) + (s.count('\(') + s.count('\)')).abs
  puts r
  r
end


@results = []

while not @infile.eof?
a = @infile.gets().to_s
  b = @infile.gets().split
  break if b.size < 2
  @infile.gets()
  v1 = b[0].to_s
  v2 = b[1].to_s 
  @results << get_distance(a, v1, v2)
end

@outfile.puts @results.join(' ')


@infile.close
@outfile.close