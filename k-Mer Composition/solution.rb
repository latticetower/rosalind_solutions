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

kmer_hash = {}

['A', 'C', 'G', 'T'].repeated_permutation(4).to_a.map{|x| x.join }.each do |key|

  kmer_hash[key.to_sym] = 0
end

str = sequences[0]
kmer = str.slice(0, 4)

kmer_hash[kmer.to_sym] += 1

(str.size - 4).times do |i|
  kmer = kmer.slice(1, 3) + str[i + 4]
  kmer_hash[kmer.to_sym] += 1
end
@outfile = File.new(@output_filename, 'w')
@outfile.puts kmer_hash.values.join(' ')
@outfile.close