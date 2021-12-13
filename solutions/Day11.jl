function tryincrement(energy :: Vector{Vector{Int}}, x, y)
	if (1 <= x <= length(energy)) && (1 <= y <= length(first(energy)))
		energy[x][y] += 1
	end
end

function part1()
	lines = readlines("inputD11.txt")
	energy = [[parse(Int, i) for i in line] for line in lines]

	flashes = 0
	for step in 1:100
		energy = [[i+1 for i in row] for row in energy]
		flashed = Tuple{Int, Int}[]
		oldflashed = 0
		running = true
		while running
			for (x, row) in enumerate(energy)
				for (y, val) in enumerate(row)
					if val >= 10 && !((x, y) in flashed)
						push!(flashed, (x, y))
						tryincrement(energy, x - 1, y - 1)
						tryincrement(energy, x - 1, y)
						tryincrement(energy, x - 1, y + 1)
						tryincrement(energy, x, y - 1)
						tryincrement(energy, x, y + 1)
						tryincrement(energy, x + 1, y - 1)
						tryincrement(energy, x + 1, y)
						tryincrement(energy, x + 1, y + 1)
					end
				end
			end

			numflashed = length(flashed)

			if numflashed == oldflashed
				running = false
				flashes += numflashed
			else
				oldflashed = numflashed
			end
		end

		for x in 1:length(energy)
			for y in 1:length(energy[x])
				if energy[x][y] >= 10
					energy[x][y] = 0
				end
			end
		end
	end

	return flashes
end

function part2()
	lines = readlines("inputD11.txt")
	energy = [[parse(Int, i) for i in line] for line in lines]

	flashes = 0
	step = 0
	while true
		step += 1
		energy = [[i+1 for i in row] for row in energy]
		flashed = Tuple{Int, Int}[]
		oldflashed = 0
		running = true
		while running
			for (x, row) in enumerate(energy)
				for (y, val) in enumerate(row)
					if val >= 10 && !((x, y) in flashed)
						push!(flashed, (x, y))
						tryincrement(energy, x - 1, y - 1)
						tryincrement(energy, x - 1, y)
						tryincrement(energy, x - 1, y + 1)
						tryincrement(energy, x, y - 1)
						tryincrement(energy, x, y + 1)
						tryincrement(energy, x + 1, y - 1)
						tryincrement(energy, x + 1, y)
						tryincrement(energy, x + 1, y + 1)
					end
				end
			end

			numflashed = length(flashed)

			if numflashed == oldflashed
				running = false
				flashes += numflashed
			else
				oldflashed = numflashed
			end
		end

		for x in 1:length(energy)
			for y in 1:length(energy[x])
				if energy[x][y] >= 10
					energy[x][y] = 0
				end
			end
		end
		
		if iszero(energy)
			return step
		end
	end
end

println(part1())
println(part2())