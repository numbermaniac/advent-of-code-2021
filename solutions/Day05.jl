function increment(visited :: Dict{Tuple{Int, Int}, Int}, x :: Int, y :: Int)
    if haskey(visited, (x, y))
        visited[(x, y)] += 1
    else
        visited[(x, y)] = 1
    end
end

function readedges()
    lines = readlines("inputD5.txt")
    edges :: Vector{Vector{Tuple{Int, Int}}} = []
    for line in lines
        left, right = split(line, "->")
        x1, y1 = [parse(Int, i) for i in split(left, ",")]
        x2, y2 = [parse(Int, i) for i in split(right, ",")]
        push!(edges, [(x1, y1), (x2, y2)])
    end

    return edges
end

function part1()
    edges = readedges()
    visited = Dict{Tuple{Int, Int}, Int}()
    for edge in edges
        x1, y1, x2, y2 = edge[1][1], edge[1][2], edge[2][1], edge[2][2]
        if x1 == x2 && y1 != y2
            if y1 > y2
                y1, y2 = y2, y1
            end

            for y in y1:y2
                increment(visited, x1, y)
            end
        elseif y1 == y2 && x1 != x2
            if x1 > x2
                x1, x2 = x2, x1
            end

            for x in x1:x2
                increment(visited, x, y1)
            end
        end
    end

    return sum([hits >= 2 for (coord, hits) in visited])
end

function part2()
    edges = readedges()
    visited = Dict{Tuple{Int, Int}, Int}()
    for edge in edges
        x1, y1, x2, y2 = edge[1][1], edge[1][2], edge[2][1], edge[2][2]
        if x1 == x2 && y1 != y2
            if y1 > y2
                y1, y2 = y2, y1
            end

            for y in y1:y2
                increment(visited, x1, y)
            end
        elseif y1 == y2 && x1 != x2
            if x1 > x2
                x1, x2 = x2, x1
            end

            for x in x1:x2
                increment(visited, x, y1)
            end
        elseif x1 != x2 && y1 != y2
            xfactor = x1 < x2 ? 1 : -1 
            yfactor = y1 < y2 ? 1 : -1

            for inc in 0:abs(y2-y1)
                increment(visited, x1 + xfactor * inc, y1 + yfactor * inc)
            end
        end
    end

    return sum([hits >= 2 for (coord, hits) in visited])
end

println(part1())
println(part2())