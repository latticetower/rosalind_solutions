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

def is_transition?(a, b)
  (([a, b] & ['A', 'G'] ).size == 2 ) || (([a, b] & ['C', 'T'] ).size == 2 )
end

# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
sequences = read_fasta(@input_filename).to_a

@output_filename = "output.txt"

transversions = 0.0
transitions = 0.0

sequences[0].size.times do |i|
  if sequences[0][i] != sequences[1][i]
    if is_transition?(sequences[0][i], sequences[1][i])
      transitions += 1.0
    else
      transversions += 1.0
    end
  end
end
puts transitions
@outfile = File.new(@output_filename, 'w')

@outfile.puts transitions/transversions

@outfile.close