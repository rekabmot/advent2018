require 'pry'

input = []

File.open('input.txt', 'r') do |f|
    f.each_line do |l|
        input << l
    end
end

input = input.map(&:to_i)

frequency = 0

seen_frequencies = [frequency]

while true
    input.each do |i|
        frequency += i

        if seen_frequencies.include? frequency
            puts frequency
            raise "done"
        end

        seen_frequencies << frequency
    end
end