function part1()
	crabs = [parse(Int, i) for i in split(readline("inputD7.txt"), ",")]
	highest = maximum(crabs)
	minfuel = minimum(n -> sum(abs(n - c) for c in crabs), 1:highest)

	return minfuel
end

function part2()
	crabs = [parse(Int, i) for i in split(readline("inputD7.txt"), ",")]
	highest = maximum(crabs)
	minfuel = minimum((n -> sum(sum(1:abs(n - c)) for c in crabs)), 1:highest)

	return minfuel
end

function part1_broadcasted()
	# An alternative solution to part1 that uses broadcasting instead of for-loops
	crabs = parse.(Int, split(readline("inputD7.txt"), ","))
	highest = maximum(crabs)
	minfuel = minimum(n -> sum(abs.(n .- crabs)), 1:highest)

	return minfuel
end

println(part1())
println(part2())