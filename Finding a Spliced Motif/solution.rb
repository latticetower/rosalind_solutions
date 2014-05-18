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



# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
sequences = read_fasta(@input_filename).to_a

@output_filename = "output.txt"

result = []
k = -1
sequences[1].size.times do |i|
  k += 1
  while (sequences[1][i] != sequences[0][k]) do
    k += 1
  end
  result << k + 1
end

@outfile = File.new(@output_filename, 'w')
@outfile.puts result.join(' ')
@outfile.close