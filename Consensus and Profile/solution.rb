@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

profileMatrix = {}
counter=0
while not @infile.eof
  l2 = @infile.gets()
  if l2[0] == '>'
    counter = 0
    l2 = @infile.gets()
  end
  
  profileMatrix['A'] = Array.new if profileMatrix['A'].nil?
  profileMatrix['C'] = Array.new if profileMatrix['C'].nil?
  profileMatrix['G'] = Array.new if profileMatrix['G'].nil?
  profileMatrix['T'] = Array.new if profileMatrix['T'].nil?
  l2.length.times do |i|
    profileMatrix['A'][counter + i] = 0 if profileMatrix['A'][counter + i].nil? and "ACGT".include?(l2[i])
    profileMatrix['C'][counter + i] = 0 if profileMatrix['C'][counter + i].nil? and "ACGT".include?(l2[i])
    profileMatrix['G'][counter + i] = 0 if profileMatrix['G'][counter + i].nil? and "ACGT".include?(l2[i])
    profileMatrix['T'][counter + i] = 0 if profileMatrix['T'][counter + i].nil? and "ACGT".include?(l2[i])

    if l2[i] == 'A'
      profileMatrix['A'][counter + i] = profileMatrix['A'][counter + i] + 1
    end
    if l2[i] == 'C'
      profileMatrix['C'][counter + i] = profileMatrix['C'][counter + i] + 1
    end
    if l2[i] == 'G'
      profileMatrix['G'][counter + i] = profileMatrix['G'][counter + i] + 1
    end
    if l2[i] == 'T'
      profileMatrix['T'][counter + i] = profileMatrix['T'][counter + i] + 1
    end
  end
  counter = counter + l2.length - 1
end
s=''
profileMatrix['A'].length.times do |i|
   m = [
   profileMatrix['A'][i], 
   profileMatrix['C'][i], 
   profileMatrix['G'][i], 
   profileMatrix['T'][i] ].max
   if m == profileMatrix['A'][i]
    s = s + 'A' 
   else
     if m == profileMatrix['C'][i]
      s = s + 'C' 
     else
       if m == profileMatrix['G'][i]
        s = s + 'G'
       else
         if m == profileMatrix['T'][i]
          s = s + 'T' 
         end
       end
     end
   end
end
@outfile.puts("#{s}")
@outfile.puts("A: #{profileMatrix['A'].join(' ')}")
@outfile.puts("C: #{profileMatrix['C'].join(' ')}")
@outfile.puts("G: #{profileMatrix['G'].join(' ')}")
@outfile.puts("T: #{profileMatrix['T'].join(' ')}")

@infile.close
@outfile.close