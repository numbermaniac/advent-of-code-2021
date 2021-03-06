function setup()
	lines = readlines("inputD13.txt")
	dots = Tuple{Int, Int}[]
	folds = Tuple{Char, Int}[]

	for line in lines
		if startswith(line, "fold")
			left, right = split(line, "=")
			left = last(left)
			right = parse(Int, right)
			push!(folds, (left, right))
		elseif line != ""
				x, y = [parse(Int, i) for i in split(line, ",")]
				push!(dots, (x, y))
		end
	end

	return (dots, folds)
end

function folddots(folddir :: Char, foldcoord :: Int, dots :: Vector{Tuple{Int, Int}})
	newdots = Tuple{Int, Int}[]
	if folddir == 'x'
		for dot in dots
			x, y = dot
			x < foldcoord ? push!(newdots, dot) : push!(newdots, (foldcoord * 2 - x, y))
		end
	
	elseif folddir == 'y'
		for dot in dots
			x, y = dot
			y < foldcoord ? push!(newdots, dot) : push!(newdots, (x, foldcoord * 2 - y))
		end
	end

	return newdots
end

function part1()
	dots, folds = setup()

	folddir, foldcoord = first(folds)
	newdots = folddots(folddir, foldcoord, dots)

	return length(Set(newdots))
end

function part2()
	dots, folds = setup()
	for (folddir, foldcoord) in folds
		dots = folddots(folddir, foldcoord, dots)
	end
	dots = Set(dots)

	highest = maximum(maximum.(dots))
	for i in 0:5
		for j in 0:highest
			print((j, i) in dots ? "#" : " ")
		end
		println()
	end

end

println(part1())
part2()