@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

@dnaCodonTable = { 'TTT' => 'F', 'CTT' => 'L', 'ATT' => 'I', 'GTT' => 'V',
'TTC' => 'F', 'CTC' => 'L', 'ATC' => 'I', 'GTC' => 'V',
'TTA' => 'L', 'CTA' => 'L', 'ATA' => 'I', 'GTA' => 'V',
'TTG' => 'L', 'CTG' => 'L', 'ATG' => 'M', 'GTG' => 'V',
'TCT' => 'S', 'CCT' => 'P', 'ACT' => 'T', 'GCT' => 'A',
'TCC' => 'S', 'CCC' => 'P', 'ACC' => 'T', 'GCC' => 'A',
'TCA' => 'S', 'CCA' => 'P', 'ACA' => 'T', 'GCA' => 'A',
'TCG' => 'S', 'CCG' => 'P', 'ACG' => 'T', 'GCG' => 'A',
'TAT' => 'Y', 'CAT' => 'H', 'AAT' => 'N', 'GAT' => 'D',
'TAC' => 'Y', 'CAC' => 'H', 'AAC' => 'N', 'GAC' => 'D',
'TAA' => 'Stop', 'CAA' => 'Q', 'AAA' => 'K', 'GAA' => 'E',
'TAG' => 'Stop', 'CAG' => 'Q', 'AAG' => 'K', 'GAG' => 'E',
'TGT' => 'C', 'CGT' => 'R', 'AGT' => 'S', 'GGT' => 'G',
'TGC' => 'C', 'CGC' => 'R', 'AGC' => 'S', 'GGC' => 'G',
'TGA' => 'Stop', 'CGA' => 'R', 'AGA' => 'R', 'GGA' => 'G',
'TGG' => 'W', 'CGG' => 'R', 'AGG' => 'R', 'GGG' => 'G'
} 
def getDNAStr(s)
  st = ""
  (s.length/3).times do |k|
    c = @dnaCodonTable[s[k*3,3]]
    if c == "Stop"
      return st
    else
      st = st + c
    end
  end
  ""
end 
def encodedStr(s)
  i = s.index('ATG')
  a = []
  while not i.nil?
    a << getDNAStr(s[i, s.length - i])
    i = s.index('ATG', i + 1) 
  end
  a
end

def complementStr(s)
  st = ""
  s.length.times do |i|
    if s[i] == "A"
      st = st + "T"
    end
    if s[i] == "T"
      st = st + "A"
    end
    if s[i] == "G"
      st = st + "C"
    end
    if s[i] == "C"
      st = st + "G"
    end
  end
  st
end

s = @infile.gets()
s=""
while not @infile.eof
  s = s + @infile.gets()
end
s = s.tr('^ACGT', '')

a = encodedStr(s)
a.concat(encodedStr(complementStr(s).reverse)).uniq!
a.each do |str|
  @outfile.puts str if str.length > 0
end

@infile.close
@outfile.close