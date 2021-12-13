function findbingos(boards :: Vector{Vector{Int}}, drawn_nums)
    bingoboards :: Vector{Vector{Int}} = []
    for board in boards
        bingo = false
        for row in [1:5, 6:10, 11:15, 16:20, 21:25]
            if all([number in drawn_nums for number in board[row]])
                bingo = true
            end
        end

        for column in [1:5:21, 2:5:22, 3:5:23, 4:5:24, 5:5:25]
            if all([number in drawn_nums for number in board[column]])
                bingo = true
            end
        end

        if bingo
            push!(bingoboards, board)
        end
    end

    return bingoboards
end

function part1()
    lines = readlines("inputD4.txt")
    draws = [parse(Int, i) for i in split(lines[1], ",")]
    boards :: Vector{Vector{Int}} = []

    linenum = 3
    while linenum < length(lines)
        push!(boards, Int[])
        for inc in 0:4
            append!(last(boards), [parse(Int, i) for i in split(lines[linenum + inc])])
        end

        linenum += 6
    end
    
    drawn_nums = Int[]
    for draw in draws
        push!(drawn_nums, draw)
        bingos = findbingos(boards, drawn_nums)
        if length(bingos) == 1
            unmarked_sum = sum([n for n in bingos[1] if !(n in drawn_nums)])
            return unmarked_sum * draw
        end
    end
end

function part2()
    lines = readlines("inputD4.txt")
    draws = [parse(Int, i) for i in split(lines[1], ",")]
    boards :: Vector{Vector{Int}} = []

    linenum = 3
    while linenum < length(lines)
        push!(boards, Int[])
        for inc in 0:4
            append!(last(boards), [parse(Int, i) for i in split(lines[linenum + inc])])
        end

        linenum += 6
    end
    
    drawn_nums = Int[]
    bingosinorder = []
    for draw in draws
        push!(drawn_nums, draw)
        bingos = findbingos(boards, drawn_nums)
        newbingos = [b for b in bingos if !(b in bingosinorder)]
        for newbingo in newbingos
            push!(bingosinorder, newbingo)
        end

        if length(bingos) == length(boards)
            last_board = last(bingosinorder)
            unmarked_sum = sum([n for n in last_board if !(n in drawn_nums)])
            return unmarked_sum * draw
        end 
    end 
end

println(part1())
println(part2())