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

def get_dp(s1, s2)
  i = 0
  [s2.size, s1.size].min.times do |k|
    i += 1 if s1[k] != s2[k]
  end
  i*1.0/s1.size
end


# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@strings_arr = []

lines_array = read_fasta(@input_filename).to_a

@outfile = File.new(@output_filename, 'w')

n = lines_array.size
@d = Array.new(n) { Array.new(n) {0.0} }

(n).times do |i|
  (n - i).times do |j|
    @d[i][i + j] = get_dp(lines_array[i], lines_array[i+j])
    @d[i + j][i] = @d[i][i + j]
  end
end
n.times do |i|
  @outfile.puts @d[i].map{|x| "%1.5f" % x }.join(' ')
end

@outfile.close