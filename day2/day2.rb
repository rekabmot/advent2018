input = []

File.open('input.txt', 'r') do |f|
    f.each_line do |l|
        input << l
    end
end

match2 = 0
match3 = 0

input.each do |line|
    breakdown = {}

    line.chars.each do |c|
        breakdown[c] ? breakdown[c] += 1 : breakdown[c] = 1
    end
    
    match2 += 1 if breakdown.values.include? 2
    match3 += 1 if breakdown.values.include? 3
end

puts match2
puts match3

puts match2 * match3