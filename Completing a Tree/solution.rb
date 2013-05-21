@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')



@adj_list = Hash.new
@marks_list = Hash.new

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

n = @infile.gets().to_i

while not @infile.eof?
  a = @infile.gets().split
  break if a.size < 2
  v1 = a[0].to_i.to_s
  v2 = a[1].to_i.to_s
  if not @adj_list.has_key? v1
    @adj_list[v1] = [v2]
  else
    @adj_list[v1] << v2
  end
  if not @adj_list.has_key? v2
    @adj_list[v2] = [v1]
  else
    @adj_list[v2] << v1
  end
end

counter = 0
i=0
start_key = @adj_list.keys[0]
while not i.nil?
  counter = counter + 1 
  start_key = @adj_list.keys[i] if not i.nil?

  bfs(@adj_list, @marks_list, start_key, counter)
  i = @adj_list.keys.find_index{|x| (@marks_list.has_key?(x) ? nil : x) }
 # @outfile.puts @marks_list.keys.keep_if{|x| @marks_list[x] == counter}.join(' ')

end
@outfile.puts "#{counter + (n - @marks_list.keys.count - 1)}" 

@infile.close
@outfile.close