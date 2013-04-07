@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

rnaCodonTable = { 'UUU' => 'F',
'CUU' => 'L', 'AUU' => 'I', 'GUU' => 'V',
'UUC' => 'F', 'CUC' => 'L', 'AUC' => 'I', 'GUC' => 'V',
'UUA' => 'L', 'CUA' => 'L', 'AUA' => 'I', 'GUA' => 'V',
'UUG' => 'L', 'CUG' => 'L', 'AUG' => 'M', 'GUG' => 'V',
'UCU' => 'S', 'CCU' => 'P', 'ACU' => 'T', 'GCU' => 'A',
'UCC' => 'S', 'CCC' => 'P', 'ACC' => 'T', 'GCC' => 'A',
'UCA' => 'S', 'CCA' => 'P', 'ACA' => 'T', 'GCA' => 'A',
'UCG' => 'S', 'CCG' => 'P', 'ACG' => 'T', 'GCG' => 'A',
'UAU' => 'Y', 'CAU' => 'H', 'AAU' => 'N', 'GAU' => 'D',
'UAC' => 'Y', 'CAC' => 'H', 'AAC' => 'N', 'GAC' => 'D',
'UAA' => 'Stop', 'CAA' => 'Q', 'AAA' => 'K', 'GAA' => 'E',
'UAG' => 'Stop', 'CAG' => 'Q', 'AAG' => 'K', 'GAG' => 'E',
'UGU' => 'C', 'CGU' => 'R', 'AGU' => 'S', 'GGU' => 'G',
'UGC' => 'C', 'CGC' => 'R', 'AGC' => 'S', 'GGC' => 'G',
'UGA' => 'Stop', 'CGA' => 'R', 'AGA' => 'R', 'GGA' => 'G',
'UGG' => 'W', 'CGG' => 'R', 'AGG' => 'R', 'GGG' => 'G'
} 

s = @infile.gets()
(s.length/3).times do |k|
  c = rnaCodonTable[s[k*3,3]]
  @outfile << c if c!='Stop'
  
end


@infile.close
@outfile.close