function part1()
	lines = readlines("inputD10.txt")
	scores = Dict{Char, Int}(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
	opentoclose = Dict{Char, Char}('(' => ')', '[' => ']', '{' => '}', '<' => '>')

	score = 0

	for line in lines
		brackets = Char[]
		for char in line
			if char in keys(opentoclose)
				push!(brackets, char)
			else
				lastopen = pop!(brackets)
				if opentoclose[lastopen] != char
					score += scores[char]
					break
				end
			end
		end
	end

	return score
end

function part2()
	lines = readlines("inputD10.txt")
	opentoclose = Dict{Char, Char}('(' => ')', '[' => ']', '{' => '}', '<' => '>')

	closescores = Dict{Char, Int}(')' => 1, ']' => 2, '}' => 3, '>' => 4)
	linescores = Int[]
	for line in lines
		brackets = Char[]
		corrupted = false
		for char in line
			if char in keys(opentoclose)
				push!(brackets, char)
			else
				lastopen = pop!(brackets)
				if opentoclose[lastopen] != char
					corrupted = true
					break
				end
			end
		end

		if !corrupted
			linescore = 0
			for bracket in reverse(brackets)
				linescore *= 5
				linescore += closescores[opentoclose[bracket]]
			end
			push!(linescores, linescore)
		end
	end

	return sort(linescores)[div(length(linescores) + 1, 2)]
end

println(part1())
println(part2())