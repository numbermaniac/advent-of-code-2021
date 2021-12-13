function find(pairs :: Vector{Vector{Int}}, n :: Int)
    for idx in 1:length(pairs)
        if pairs[idx][1] == n
            return idx
        end
    end
end

function part1()
    fish = [parse(Int, i) for i in split(readline("inputD6.txt"), ",")]

    for day in 1:80
        fish .-= 1
        for n in 1:sum(fish .== -1)
            push!(fish, 8)
        end
        replace!(fish, -1 => 6)
    end

    return length(fish)
end

function part2()
    fish = [parse(Int, i) for i in split(readline("inputD6.txt"), ",")]

    totals = [[i, 0] for i in 0:8]
    for f in fish
        totals[find(totals, f)][2] += 1
    end

    for day in 1:256
        for pair in totals
            pair[1] -= 1
        end
        
        totals[find(totals, 6)][2] += totals[find(totals, -1)][2]
        totals[find(totals, -1)][1] = 8
        
    end

    return sum([i[2] for i in totals])
    
end

println(part1())
println(part2())