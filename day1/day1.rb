
input = []

File.open('input.txt', 'r') do |f|
    f.each_line do |l|
        input << l
    end
end

value = input.map(&:to_i).sum

puts value