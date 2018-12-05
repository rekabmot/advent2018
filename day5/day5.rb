require '../read_file'

input = read_file[0].strip.chars
# input = "dabAcCaCBAcCcaDA".chars

def match(a, b)
    return a.upcase == b.upcase && ((/[[:upper:]]/.match(a) && /[[:lower:]]/.match(b)) || (/[[:lower:]]/.match(a) && /[[:upper:]]/.match(b)))
end

def process(input)
    input.each_index do |i|
        a = input[i]
        b = input[i + 1]

        next unless b
        
        if (match(a, b))
            input.delete_at(i + 1)
            input.delete_at(i)
        end
    end
end

prevSize = 0
size = input.size

while size != prevSize
    prevSize = input.size
    process(input)
    size = input.size
end

puts input.size