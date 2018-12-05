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

def get_units(input)
    units = []

    input.each do |x|
        units << x.upcase unless units.include? x.upcase
    end

    units
end

def puzzle1(input)
    prevSize = 0
    size = input.size

    while size != prevSize
        prevSize = input.size
        process(input)
        size = input.size
    end
    input.size
end

def puzzle2(input)
    units = get_units(input)

    results = {}

    units.each do |u|
        results[u] = puzzle1(input.reject { |x| x == u || x == u.downcase })
    end

    key = results.keys.sort { |a, b| results[a] <=> results[b] }.first

    results[key]
end

# puts puzzle1(input)
puts puzzle2(input)