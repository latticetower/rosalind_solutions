@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

dnaStrings = {}
dnaPrefixes = {}
dnaSuffixes = {}
s = ""
currentDNA = ""
l2 = ""
while not @infile.eof
  l2 = @infile.gets()
  if l2[0] == '>'
    s = s.tr('^ACGT', '')
    if currentDNA.length > 0
      dnaStrings[currentDNA] = {:start => s[0, 3], :end => s[s.length - 3, 3]} 
      dnaPrefixes[s[0, 3]] = [] if dnaPrefixes[s[0, 3]].nil?
      dnaPrefixes[s[0, 3]] << currentDNA
      dnaSuffixes[s[s.length - 3, 3]] = [] if dnaSuffixes[s[s.length - 3, 3]].nil?
      dnaSuffixes[s[s.length - 3, 3]] << currentDNA
    end
    currentDNA = l2[1, l2.length - 2]
    s = ""
  else
    s = s + l2
  end
  
end

s = s.tr('^ACGT', '')
if currentDNA.length > 0
  dnaStrings[currentDNA] = {:start => s[0, 3], :end => s[s.length - 3, 3]} 
  dnaPrefixes[s[0, 3]] = [] if dnaPrefixes[s[0, 3]].nil?
  dnaPrefixes[s[0, 3]] << currentDNA
  dnaSuffixes[s[s.length - 3, 3]] = [] if dnaSuffixes[s[s.length - 3, 3]].nil?
  dnaSuffixes[s[s.length - 3, 3]] << currentDNA
end

overlapGraph = []
dnaStrings.keys.each do |dna|
  #dnaStrings[dna][:end] # - thus we get dna string suffix
  if not dnaPrefixes[dnaStrings[dna][:end]].nil?
    dnaPrefixes[dnaStrings[dna][:end]].each do |head|
      overlapGraph << {dna => head} if head != dna
    end
  end
end
overlapGraph.uniq!
overlapGraph.each do |pair|
  @outfile.puts "#{pair.keys.first} #{pair.values.first}"
end

@infile.close
@outfile.close