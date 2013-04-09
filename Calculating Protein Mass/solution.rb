@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')
masses = {
	'A' => 71.03711,
'C' => 103.00919,
'D' => 115.02694,
'E' => 129.04259,
'F' => 147.06841,
'G' => 57.02146,
'H' => 137.05891,
'I' => 113.08406,
'K' => 128.09496,
'L' => 113.08406,
'M' => 131.04049,
'N' => 114.04293,
'P' => 97.05276,
'Q' => 128.05858,
'R' => 156.10111,
'S' => 87.03203,
'T' => 101.04768,
'V' => 99.06841,
'W' => 186.07931,
'Y' => 163.06333,
'Water' => 18.01056
} 
str = @infile.gets()
proteinWeight = 0
str.length.times do |i|
	proteinWeight = proteinWeight + masses[str[i]]  if masses.has_key? str[i]
end
proteinWeight = proteinWeight # if proteinWeight > 0
@outfile.puts("#{proteinWeight}")

@infile.close
@outfile.close