require '../read_file'

input = read_file

class Rectangle
    attr_accessor :id, :x, :y, :w, :h

    def initialize(id, x, y, width, height)
        @id = id
        @x = x
        @y = y
        @w = width
        @h = height
    end

    def to_s
        "(#{x},#{y}) - (#{x + w},#{y + h})"
    end
end

def build_rectangles(input)
    rectangles = []
    input.each do |line|
        tokens = line.split(" ")

        pos = tokens[2].split(",")
        pos[1] = pos[1].gsub(":", "")

        dim = tokens[3].split("x")

        rectangles << Rectangle.new(tokens[0], pos[0].to_i, pos[1].to_i, dim[0].to_i, dim[1].to_i)
    end
    rectangles
end

def print_grid(grid)
    grid.each do |line|
        puts line.join
    end
end


rectangles = build_rectangles(input)
# rectangles = [
#     Rectangle.new(1, 1, 2, 2),
#     Rectangle.new(1, 2, 3, 3)
# ]

grid_size = 1000

grid = []

grid_size.times do
    grid << Array.new(grid_size, 0)
end

rectangles.each do |r|
    (r.x..(r.x + r.w - 1)).each do |i|
        (r.y..(r.y + r.h - 1)).each do |j|
            grid[i][j] += 1
        end
    end
end

# print_grid(grid)

total = 0
(0...grid_size).each do |i|
    (0...grid_size).each do |j|
        if grid[i][j] > 1
            total += 1
        end
    end
end

puts total

rectangles.each do |r|
    clear = true

    (r.x..(r.x + r.w - 1)).each do |i|
        (r.y..(r.y + r.h - 1)).each do |j|
            clear &&= grid[i][j] == 1
        end
    end

    puts r.id if clear
end

