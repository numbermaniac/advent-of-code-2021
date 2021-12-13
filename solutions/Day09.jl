function part1()
	lines = readlines("inputD9.txt")
	depths = [[parse(Int, i) for i in line] for line in lines]
	lowvals = Int[]
	
	for (i, line) in enumerate(depths)
		for (j, val) in enumerate(line)
			matches = true
			if i - 1 >= 1
				if depths[i-1][j] <= val
					matches = false
				end
			end
			if i + 1 <= length(depths)
				if depths[i+1][j] <= val
					matches = false
				end
			end
			if j - 1 >= 1
				if depths[i][j-1] <= val
					matches = false
				end
			end
			if j + 1 <= length(line)
				if depths[i][j+1] <= val
					matches = false
				end
			end

			if matches
				push!(lowvals, val)
			end
		end
	end

	return sum(lowvals .+ 1)
end

function part2()
	lines = readlines("inputD9.txt")
	depths = [[parse(Int, i) for i in line] for line in lines]
	Coordtype = NTuple{2, Int}
	lowvals = Coordtype[]
	
	for (i, line) in enumerate(depths)
		for (j, val) in enumerate(line)
			matches = true
			if i - 1 >= 1
				if depths[i-1][j] <= val
					matches = false
				end
			end
			if i + 1 <= length(depths)
				if depths[i+1][j] <= val
					matches = false
				end
			end
			if j - 1 >= 1
				if depths[i][j-1] <= val
					matches = false
				end
			end
			if j + 1 <= length(line)
				if depths[i][j+1] <= val
					matches = false
				end
			end

			if matches
				push!(lowvals, (i, j))
			end
		end
	end

	basins :: Vector{Vector{Coordtype}} = []
	for start in lowvals
		basin = Coordtype[start]
		checked = Coordtype[]
		while any((!(b in checked)) for b in basin)
			x, y = first(b for b in basin if !(b in checked))
			valatcoord = depths[x][y]
			if valatcoord < 8
				if x - 1 >= 1
					if depths[x-1][y] != 9
						push!(basin, (x-1, y))
					end
				end
				if x + 1 <= length(depths)
					if depths[x+1][y] != 9
						push!(basin, (x+1, y))
					end
				end
				if y - 1 >= 1
					if depths[x][y-1] != 9
						push!(basin, (x, y-1))
					end
				end
				if y + 1 <= length(depths[x])
					if depths[x][y+1] != 9
						push!(basin, (x, y+1))
					end
				end
			end

			push!(checked, (x, y))
		end

		basin = collect(Set(basin))
		push!(basins, basin)
	end
	return prod(reverse(sort(length.(basins)))[1:3])
end

println(part1())
println(part2())