input = []

File.open('input.txt', 'r') do |f|
    f.each_line do |l|
        input << l
    end
end

size = input.length

(0...size).each do |i|
    a = input[i].chars

    (i...size).each do |j|
        b = input[j].chars

        diffs = 0

        (0..a.length).each do |k|
            if a[k] != b[k]
                diffs += 1
            end

            if diffs > 1
                break
            end
        end

        if diffs == 1
            puts a.join
            puts b.join
        end
    end
end