function part1()
    lines = readlines("inputD3.txt")
    gammastr = ""
    for idx in 1:length(lines[1])
        zeroes = sum([number[idx] == '0' for number in lines])
        ones = length(lines) - zeroes
        if ones > zeroes
            gammastr *= "1"
        else
            gammastr *= "0"
        end
    end

    gamma = parse(Int, gammastr, base = 2)
    epsilon = Int(2 ^ ceil(log2(gamma)) - 1 - gamma)
    return gamma * epsilon
end

function part2()
    lines = readlines("inputD3.txt")
    oxyfiltered = copy(lines)
    co2filtered = copy(lines)
    for i in 1:length(lines[1])
        if length(oxyfiltered) > 1
            zeroes = sum([number[i] == '0' for number in oxyfiltered])
            ones = length(oxyfiltered) - zeroes
            if ones > zeroes || ones == zeroes
                oxyfiltered = [num for num in oxyfiltered if num[i] == '1']
            elseif ones < zeroes
                oxyfiltered = [num for num in oxyfiltered if num[i] == '0']
            end
        end

        if length(co2filtered) > 1
            co2zeroes = sum([number[i] == '0' for number in co2filtered])
            co2ones = length(co2filtered) - co2zeroes
            if co2ones > co2zeroes || co2ones == co2zeroes
                co2filtered = [num for num in co2filtered if num[i] == '0']
            elseif co2ones < co2zeroes 
                co2filtered = [num for num in co2filtered if num[i] == '1']
            end
        end
    end

    if length(co2filtered) != 1 || length(oxyfiltered) != 1
        error("???")
    end

    return parse(Int, oxyfiltered[1], base = 2) * parse(Int, co2filtered[1], base = 2)
end

println(part1())
println(part2())