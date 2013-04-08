@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

@dnaIDs = {}

@length = 0
@gc = 0
@currentDNA = ''
while not @infile.eof? do
  s = @infile.gets()
  if s[0] == '>'
    @dnaIDs[@currentDNA] = (100.0*@gc) / @length if @length > 0
    @length = 0
    @gc = 0
    @currentDNA = s[1,s.length] 
  else
    s.length.times do |i|
      @length = @length + 1 if "AGCT".include? s[i]
      @gc = @gc + 1 if "GC".include? s[i]
    end
  end
end
@dnaIDs[@currentDNA] = (100.0*@gc) / @length if @length > 0


@outfile.puts("#{@dnaIDs.key(@dnaIDs.values.max)}")
@outfile.puts("#{@dnaIDs.values.max}")

@infile.close
@outfile.close