mutable struct Value
	value :: Int
	owner# :: Union{Missing, Node} # circular dependency on each other so we'll have to leave it as Any
end

mutable struct Node
	left :: Union{Value, Node}
	right :: Union{Value, Node}
	parent :: Union{Missing, Nothing, Node}
end

function makenode(numbers :: Union{Vector, Int})
	if numbers isa Vector
		left, right = numbers
		return Node(makenode(left), makenode(right), missing)
	elseif numbers isa Int
		return Value(numbers, missing)
	end
end

function assignparents!(node :: Node)
	if node.left isa Node
		node.left.parent = node
		assignparents!(node.left)
	else
		node.left.owner = node
	end

	if node.right isa Node
		node.right.parent = node
		assignparents!(node.right)
	else
		node.right.owner = node
	end
end

function getorder!(current :: Node, result :: Vector{Value})
	for next in (current.left, current.right)
		if next isa Node
			getorder!(next, result)
		else
			push!(result, next)
		end
	end
end

function findexplodeable(values :: Vector{Value})
	eligibles = Value[]
	for value in values
		current = value.owner
		depth = 1
		while !isnothing(current.parent)
			current = current.parent
			depth += 1
		end

		if depth >= 5
			push!(eligibles, value)
		end
	end

	for index in 1:length(eligibles) - 1
		if eligibles[index].owner == eligibles[index + 1].owner
			return eligibles[index].owner
		end
	end
end

magnitude(n :: Node) = 3 * magnitude(n.left) + 2 * magnitude(n.right)
magnitude(v :: Value) = v.value

function reducetree(node1 :: Node, node2 :: Node)
	newtotal = Node(node1, node2, nothing)
	newtotal.left.parent = newtotal
	newtotal.right.parent = newtotal

	while true
		valuesinorder = Value[]
		getorder!(newtotal, valuesinorder)

		explodeable = findexplodeable(valuesinorder)

		splitindex = findfirst(v -> v.value >= 10, valuesinorder)
		
		if !isnothing(explodeable)
			left = explodeable.left
			right = explodeable.right

			leftindex = findfirst(==(left), valuesinorder)
			rightindex = findfirst(==(right), valuesinorder)
			if leftindex - 1 >= 1
				valuesinorder[leftindex - 1].value += left.value
			end

			if rightindex + 1 <= length(valuesinorder)
				valuesinorder[rightindex + 1].value += right.value
			end

			parent = explodeable.parent
			if parent.left == explodeable
				parent.left = Value(0, parent)
			else
				parent.right = Value(0, parent)
			end

		elseif !isnothing(splitindex)
			value = valuesinorder[splitindex]
			parent = value.owner

			lower = Value(Int(floor(value.value / 2)), missing)
			upper = Value(Int(ceil(value.value / 2)), missing)
			newnode = Node(lower, upper, parent)
			lower.owner = newnode
			upper.owner = newnode
			if parent.left == value
				parent.left = newnode
			else
				parent.right = newnode
			end

		else
			break # cannot be further reduced
		end
	end

	return newtotal
end

function part1()
	lines = readlines("inputD18.txt")
	snailnumbers = makenode.(eval.(Meta.parse.(lines)))

	assignparents!.(snailnumbers)

	total = first(snailnumbers)
	
	for index in 2:length(snailnumbers)
		total = reducetree(total, snailnumbers[index])
	end

	return magnitude(total)
end

function part2()
	lines = readlines("inputD18.txt")
	peakmag = 0
	for i in 1:100
		for j in 1:100
			if i != j
				println((i, j, peakmag))
				snailnumbers = makenode.(eval.(Meta.parse.(lines)))

				assignparents!.(snailnumbers)
				
				total = reducetree(snailnumbers[i], snailnumbers[j])

				mag = magnitude(total)
				if mag > peakmag
					peakmag = mag
				end
			end
		end
	end

	return peakmag
end

println(part1())
println(part2()) # warning: very slow