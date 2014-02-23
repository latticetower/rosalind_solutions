
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
          buffer = ""
        end
      end
      yielder.yield buffer if buffer.size > 0
    end
  end
end

# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@outfile = File.new(@output_filename, 'w')

@strings_hash = Hash.new

#initial implementation contains something unoptimized
lines_array = read_fasta(@input_filename).to_a
lines_array.each_with_index do |line, index|
  line.size.times do |i|
    subs = line.slice(i, line.size - i)
    subs1 = subs
    subs.size.times do |j|
      if @strings_hash.has_key?(subs1)
        @strings_hash[subs1] << index unless @strings_hash[subs1].include? index
      else
        @strings_hash[subs1] = [index]
      end
      subs1 = subs1.chop
    end
  end
end

@strings_hash.keep_if{|k, v| v.size == lines_array.size}
maxstr = @strings_hash.keys.max_by{|x| x.size }
@outfile.puts maxstr

@outfile.close