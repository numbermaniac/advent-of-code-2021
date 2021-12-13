function part1()
    lines = readlines("inputD2.txt")
    horiz = 0
    depth = 0
    for line in lines
        instruction, amount = split(line, " ")
        amount = parse(Int, amount)

        if instruction == "forward"
            horiz += amount
        elseif instruction == "up"
            depth -= amount
        elseif instruction == "down"
            depth += amount
        end
    end

    return horiz * depth
end

function part2()
    lines = readlines("inputD2.txt")
    horiz = 0
    depth = 0
    aim = 0
    for line in lines
        instruction, amount = split(line, " ")
        amount = parse(Int, amount)

        if instruction == "forward"
            horiz += amount
            depth += aim * amount
        elseif instruction == "up"
            aim -= amount
        elseif instruction == "down"
            aim += amount
        end
    end

    return horiz * depth
end

println(part1())
println(part2())