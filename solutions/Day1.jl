function part1()
    numbers = [parse(Int, i) for i in readlines("inputD1.txt")]
    return sum(numbers[2:end] .> numbers[1:end-1])
end

function part2()
    numbers = [parse(Int, i) for i in readlines("inputD1.txt")]
    return sum(numbers[4:end] .> numbers[1:end-3])
end

println(part1())
println(part2())