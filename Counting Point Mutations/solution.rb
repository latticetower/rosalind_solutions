@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')


def dH(s,t)
  c = 0
  s.length.times do |i|
    if (s[i] != t[i] and "AGCT".include? s[i])
      c = c + 1
    end
  end
  c
end
s = @infile.gets()
t = @infile.gets()



@outfile.puts("#{dH(s,t)}")

@infile.close
@outfile.close