require '../read_file'

input = read_file

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