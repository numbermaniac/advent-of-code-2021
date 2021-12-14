function tryincrement(counter :: Dict{T, Int}, key :: T, amount :: Int = 1) where T
	haskey(counter, key) ? counter[key] += amount : counter[key] = amount
end

function setup()
	lines = readlines("inputD14.txt")
	pattern = lines[1]
	pairs = Dict{String, String}()

	for line in lines[3:end]
		left, right = split(line, " -> ")
		right = left[1] * right * left[2]
		pairs[left] = right
	end

	return (pattern, pairs)
end

function part1()
	# A brute-force solution, for reference
	# Won't work for part 2 because the size of the string gets far too big
	pattern, pairs = setup()

	for step in 1:10
		broken = [pattern[index] * pattern[index + 1] for index in 1:length(pattern)-1]
		broken = [get(pairs, b, b) for b in broken]

		pattern = join(b[1:end-1] for b in broken)
		pattern *= broken[end][end]
	end

	counter = Dict{Char, Int}()
	for char in pattern
		tryincrement(counter, char)
	end

	return maximum(values(counter)) - minimum(values(counter))
end

function part2()
	pattern, pairs = setup()
	letterpairs = Dict{String, Int}()
	totalcounts = Dict{Char, Int}()

	for char in pattern
		tryincrement(totalcounts, char)
	end

	for index in 1:length(pattern)-1
		tryincrement(letterpairs, pattern[index] * pattern[index + 1])
	end

	for step in 1:40
		newletterpairs = Dict{String, Int}()
		for letters in keys(letterpairs)
			result = get(pairs, letters, letters)
			amount = letterpairs[letters]
			if length(result) == 2
				tryincrement(newletterpairs, letters, amount)
			else # implies length(result) == 3
				tryincrement(newletterpairs, result[1:2], amount)
				tryincrement(newletterpairs, result[2:3], amount)
				tryincrement(totalcounts, result[2], amount)
			end
		end

		letterpairs = copy(newletterpairs)
	end

	return maximum(values(totalcounts)) - minimum(values(totalcounts))
end

println(part1())
println(part2())