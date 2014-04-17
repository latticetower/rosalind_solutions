require 'open-uri'
# -------------
# functions
# -------------

def find_motif(data)
  pos = data.index(/N[^P][ST][^P]/)
  result = []
  while not pos.nil? do
    result << pos + 1
    pos = data.index(/N[^P][ST][^P]/, pos + 1)
  end
  result
end


# --------------------
# main code
# --------------------

@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@proteins = []
File.open(@input_filename, 'r') do |file|
  while not file.eof do
    @proteins << file.gets.strip
  end
end


@outfile = File.new(@output_filename, 'w')
@data = {}

@proteins.each do |protein|
  open("http://www.uniprot.org/uniprot/#{protein}.fasta") {|f|
 
    sequence = "" 
    f.each_line do |line|
      @data[protein] ||= ""
      string_buffer = line.strip
      if string_buffer.index('>').nil?
        @data[protein] << string_buffer
      end
    end
  }
end

@proteins.each do |protein|
  res = find_motif(@data[protein].upcase)
  @outfile.puts(protein, res.join(' ')) if res.size > 0 
end

@outfile.close