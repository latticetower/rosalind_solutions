@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

def prob(k,m,n)
	return (k*(k-1) + 0.75*m*(m-1) + 2*k*m + 2*k*n+m*n)/((k + m + n)*(k + m + n - 1))
	
end
a0 = @infile.gets().split
k = a0[0].to_i
m = a0[1].to_i
n = a0[2].to_i


@outfile.puts("#{prob(k,m,n)}")

@infile.close
@outfile.close