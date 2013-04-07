@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

def rabbits(n, k)
  rabbitGenerations = Array.new
    n.times do |nth|
      if (nth <= 1)
        rabbitGenerations[nth] = 1
      else
        rabbitGenerations[nth] = rabbitGenerations[nth - 1] + k*rabbitGenerations[nth - 2]
      end
    end
    return rabbitGenerations[n-1]
end
a0 = @infile.gets().split
n = a0[0].to_i
k = a0[1].to_i



@outfile.puts("#{rabbits(n,k)}")

@infile.close
@outfile.close