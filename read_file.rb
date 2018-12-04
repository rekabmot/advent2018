
def read_file
    input = []
    File.open('input.txt', 'r') do |f|
        f.each_line do |l|
            input << l
        end
    end
    input
end