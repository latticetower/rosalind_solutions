@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')



@adj_list = Hash.new
@marks_list = Hash.new

def fill_adjacensy_list(newick_str)
 a =  newick_str.scan(/(?:(?<f1>\((?:(?>\\[()]|[^()])|\g<f1>)*\)))?(?<f2>\w*)\,?(?:(?<f3>\((?:(?>\\[()]|[^()])|\g<f3>)*\)))?(?<f4>\w*)?/)
 puts a.join('-')
@adj_list[newick_str] = [] if not @adj_list.has_key? newick_str
    
  if not a[1].nil?
    @adj_list[newick_str] << a[1]
    @adj_list[a[1]] = [] if not @adj_list.has_key? a[1]
    @adj_list[a[1]] << newick_str
    fill_adjacensy_list(arr[0])
  else
    @adj_list[newick_str] << a[0]
    @adj_list[a[0]] = [] if not @adj_list.has_key? a[0]
    @adj_list[a[0]] << newick_str
    fill_adjacensy_list(a[0])
  end

 puts a.join(' - ') 
end

def bfs(adj_list, marks_list, start_vertex, group_index)
  a = [start_vertex]
  marks_list[start_vertex] = group_index
  while a.size > 0 
    v = a.shift
    if adj_list.has_key? v
      adj_list[v].each do |v2|
        if marks_list[v2].nil?
          marks_list[v2] = group_index
          a.unshift(v2)
        end
      end
    end
  end
end

n = 0

while not @infile.eof?
  @adj_list = Hash.new
  fill_adjacensy_list(@infile.gets().to_s)
  b = @infile.gets().split
  break if b.size < 2
  #puts @adj_list.keys.join(' ')

  v1 = b[0].to_s
  v2 = b[1].to_s
  n = n + 1
end

#counter = 0
#i=0
#start_key = @adj_list.keys[0]
#while not i.nil?
#  counter = counter + 1 
#  start_key = @adj_list.keys[i] if not i.nil?

#  bfs(@adj_list, @marks_list, start_key, counter)
#  i = @adj_list.keys.find_index{|x| (@marks_list.has_key?(x) ? nil : x) }
 # @outfile.puts @marks_list.keys.keep_if{|x| @marks_list[x] == counter}.join(' ')

#end
#@outfile.puts "#{counter + (n - @marks_list.keys.count - 1)}" 

@infile.close
@outfile.close