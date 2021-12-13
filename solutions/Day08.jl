using Combinatorics

function part1()
	lines = readlines("inputD8.txt")
	easies = Int[2,4,3,7]
	counter = 0

	for line in lines
		afterpipe = split(line, "|")[2]
		words = split(afterpipe)
		counter += sum([length(word) in easies for word in words])
	end

	return counter
end

function part2()
	lines = readlines("inputD8.txt")
	letters_to_digit = Dict{String, Int}("abcefg" => 0, "abcdefg" => 8, "abdefg" => 6, "abcdfg" => 9, "cf" => 1, "abdfg" => 5, "bcdf" => 4, "acdeg" => 2, "acf" => 7, "acdfg" => 3)

	ordered = ["a", "b", "c", "d", "e", "f", "g"]
	perms = collect(permutations(ordered))
	total = 0
	for line in lines
		splitbypipe = split(line, "|")
		beforepipe = split.(split(splitbypipe[1]), "")
		for perm in perms
			mapping = Dict(ordered .=> perm)

			replaced = [[get(mapping, j, j) for j in b] for b in beforepipe]
			sorted = join.(sort.(replaced))

			if all(r in keys(letters_to_digit) for r in sorted)
				# wow, we did it
				afterpipe = split.(split(splitbypipe[2]), "")
				
				afterpipereplaced = [[get(mapping, j, j) for j in a] for a in afterpipe]
				afterpipesorted = join.(sort.(afterpipereplaced))
				
				final_number = parse(Int, join([letters_to_digit[i] for i in afterpipesorted]))
				total += final_number
				break
			end
		end
	end

	return total
end

println(part1())
println(part2())