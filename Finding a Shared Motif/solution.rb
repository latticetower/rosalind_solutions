require 'algorithms'
# -------------
# functions
# -------------
def read_fasta(filename)
  Enumerator.new do |yielder|
    buffer = ""
    File.open(filename) do |file|
      while not file.eof?
        string_buffer = file.gets.strip
        if string_buffer.index('>').nil?
          buffer << string_buffer
        else
          yielder.yield buffer if buffer.size > 0 
          yield buffer if block_given?
          buffer = ""
        end
      end
      yielder.yield buffer if buffer.size > 0
      yield buffer if block_given?
    end
  end
end

def get_substr(str1, str2)
  return get_substr(str2, str1) if str1.size > str2.size
  arr = []
  buf = ""
 
  str1.size.times do |j|
    arr1 = []
    str2.size.times do |i|
      k = 0
      buf = ""
      while str2[i + k] == str1[j + k]
        buf << str2[i + k]
        k += 1
        break if i + k >= str2.size
        break if j + k >= str1.size
      end
      arr1 << buf if buf.size > 0 #&& arr.select{|x| x[buf].nil? }.size == 0
      return [buf] if k == str1.size
    end
    m = arr1.max_by{|x| x.size }
    arr += arr1.select{|x| x.size == m.size}
  end
  arr
end
# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@outfile = File.new(@output_filename, 'w')

@strings_arr = []

#initial implementation contains something unoptimized
lines_array = read_fasta(@input_filename).to_a
@strings_arr << lines_array[0]
(lines_array.size - 1).times do |k|
  @strings_arr = @strings_arr.map{|line_subs| get_substr(line_subs, lines_array[k + 1]) }.flatten.uniq
  puts "____#{@strings_arr.size}________#{k+1}___"
end

maxstr = @strings_arr.max_by{|x| x.size }
@outfile.puts maxstr

@outfile.close