@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

@adj_list = Hash.new
def add_adj(v1, v2, w)
  @adj_list[v1] = {} if not @adj_list.has_key? v1
  @adj_list[v2] = {} if not @adj_list.has_key? v2
  @adj_list[v1][v2] = w
  @adj_list[v2][v1] = w
end

def fill_adjacensies(newick_str)
  substr = newick_str[(newick_str.index('(') + 1)..(newick_str.rindex(')')-1)]
  s = substr.scan(/(?<f1>(\((?:(?>\\[()]|[^()])|\g<f1>)*\)|(?:[^\(\)\,]+))[^\(\)\:\,]*:?[0-9]*)/).flatten
  s.each do |ss|
    weight = ss[(ss.rindex("\:")+1)..-1].to_i
    ss1 = ss[0..(ss.rindex("\:")-1)]
    add_adj(newick_str, ss1, weight)
    if not ss.index('(').nil?
      fill_adjacensies(ss1)
    end
  end
end


def get_distance(vstart, vend)
  @dist_list = Hash.new
  a = [vstart]
  @dist_list[vstart] = 0
  while a.size > 0
    v = a.shift
    if @adj_list.has_key? v
      @adj_list[v].each_pair do |v2, w|
        if @dist_list[v2].nil?
          @dist_list[v2] = @dist_list[v] + w
          a.unshift(v2)
        else
          @dist_list[v2] = [@dist_list[v2], @dist_list[v] + w].min
        end
      end
    end
  end
  #puts @dist_list
  @dist_list[vend]
end


@results = []

while not @infile.eof?
  @adj_list = Hash.new
  a = @infile.gets().to_s.chomp
  b = @infile.gets().split
  break if b.size < 2
  @infile.gets()
  v1 = b[0].to_s
  v2 = b[1].to_s
  fill_adjacensies(a) 
  @results << get_distance(v1, v2)
end

@outfile.puts @results.join(' ')


@infile.close
@outfile.close