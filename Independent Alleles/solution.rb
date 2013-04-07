@input_filename = "input.txt"
@input_filename = ARGV[0] if ARGV.count >= 1
@output_filename = "output.txt"

@infile = File.new(@input_filename, 'r')
@outfile = File.new(@output_filename, 'w')

def pr(k,s)
  if k == 0
    return 1 if s == "Aa"
    return 0
  end
  if k == 1
    return 0.5 if s == "Aa"
    return 0.25 if s == "aa"
    return 0.25 if s == "AA"
  end
  if s == "Aa"
    return 0.5*pr(k-1, "AA") + 0.5*pr(k-1, "Aa") + 0.5*pr(k-1, "aa") 
  end
  if s == "aa"
    return 0.25*pr(k-1, "Aa") + 0.5*pr(k-1, "aa") 
  end
  if s == "AA"
    return 0.5*pr(k-1, "AA") + 0.25*pr(k-1, "Aa") 
  end
  0
end
@cArr = {}
def cnk(n, k) 
  return @cArr[k.to_s] if @cArr.has_key? k.to_s
  @cArr[k.to_s] = 1 if k==0
  if k == n
    @cArr[k.to_s] = 1
    return 1
  end
  c0 = 1
  k.times do |l|
    c0 = c0 * (n - k + l + 1)/(l + 1)
  end
  @cArr[k.to_s] = c0
  return c0
end
def pBernulli(k, n, p)
  cnk(n, k)*(p**k)*((1-p)**(n-k))
end
a0 = @infile.gets().split
k = a0[0].to_i
n = a0[1].to_i

p1 = pr(k, "Aa")

pFinal = 0
n.times do |o|
  pFinal = pFinal + pBernulli(o, 2**k, p1*p1)
end

@outfile.puts("#{(1 - pFinal).to_f}")

@infile.close
@outfile.close