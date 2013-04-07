@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

def rabbits(n, m)
  adults = Array.new
  newborns = Array.new
  
  n.times do |nth|
    if (nth == 0)
      newborns[0] = 1
      adults[0] = 0
    end
    if (nth == 1)
      newborns[1] = 0
      adults[1] = 1
    end
    if (nth > 1)
      adults[nth] = adults[nth - 1] + newborns[nth - 1]
      newborns[nth] = adults[nth - 1] 
      if (nth >= m)
       adults[nth] = adults[nth] - newborns[nth - m]
       newborns[nth] = newborns[nth] 
      end
      newborns[nth] = 0 if (newborns[nth]<0)
    end
    puts "#{nth}: #{newborns[nth]} + #{adults[nth]}"
  end
  adults[n-1] + newborns[n-1]
end
a0 = @infile.gets().split
n = a0[0].to_i
m = a0[1].to_i



@outfile.puts("#{rabbits(n,m)}")

@infile.close
@outfile.close