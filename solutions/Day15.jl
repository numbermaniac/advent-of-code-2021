mutable struct Node
	x :: Int
	y :: Int
	value :: Int
	bestdist :: Int
end

struct Edge
	sideA :: Node
	sideB :: Node
end

other(edge :: Edge, node :: Node) = node == edge.sideA ? edge.sideB : node == edge.sideB ? edge.sideA : error("node not on either edge")
getedges(n :: Node, edges :: Vector{Edge}) = [edge for edge in edges if edge.sideA == n || edge.sideB == n]
makenode(value :: Int, x :: Int, y :: Int) = Node(x, y, value, typemax(Int))

function create_edges(grid_to_node :: Dict{Tuple{Int, Int}, Node})
	nodes = values(grid_to_node)
	edges_from_node = Dict{Node, Vector{Edge}}(n => Edge[] for n in nodes)
	for node in nodes
		if haskey(grid_to_node, (node.x + 1, node.y))
			target_node = grid_to_node[(node.x + 1, node.y)]
			new_edge = Edge(node, target_node)
			push!(edges_from_node[node], new_edge)
			push!(edges_from_node[target_node], new_edge)
		end

		if haskey(grid_to_node, (node.x, node.y + 1))
			target_node = grid_to_node[(node.x, node.y + 1)]
			new_edge = Edge(node, target_node)
			push!(edges_from_node[node], new_edge)
			push!(edges_from_node[target_node], new_edge)
		end
	end

	return edges_from_node
end

function dijkstra!(grid_to_node :: Dict{Tuple{Int, Int}, Node}, edges_from_node :: Dict{Node, Vector{Edge}})
	grid_to_node[(1, 1)].bestdist = 0
	eligibles = Set{Node}([grid_to_node[(1, 1)]])
	counter = 0
	
	while counter < length(grid_to_node)
		current = argmin(n -> n.bestdist, eligibles)
		node_edges = edges_from_node[current]
		for other_edge in node_edges
			target = other(other_edge, current)
			if current.bestdist + target.value < target.bestdist
				target.bestdist = current.bestdist + target.value
				push!(eligibles, target)
			end
		end

		pop!(eligibles, current)
		counter += 1
	end
	# modifies in-place, return not needed
end

function part1()
	lines = readlines("inputD15.txt")

	grid_to_node = Dict{Tuple{Int, Int}, Node}()
	for (i, line) in enumerate(lines)
		for (j, value) in enumerate(line)
			grid_to_node[(i, j)] = makenode(parse(Int, value), i, j)
		end
	end
	
	edges_from_node = create_edges(grid_to_node)
	dijkstra!(grid_to_node, edges_from_node)

	return grid_to_node[(100, 100)].bestdist
end

function add(n :: Int, amount :: Int)
	for _ in 1:amount
		n == 9 ? n = 1 : n += 1
	end

	return n
end

function part2()
	lines = readlines("inputD15.txt")

	grid_to_node = Dict{Tuple{Int, Int}, Node}()
	for (i, line) in enumerate(lines)
		for (j, value) in enumerate(line)
			value = parse(Int, value)
			for m in 0:4
				for n in 0:4
					grid_to_node[(i+n*100, j+m*100)] = makenode(add(value, n+m), i+n*100, j+m*100)
				end
			end
		end
	end

	edges_from_node = create_edges(grid_to_node)
	dijkstra!(grid_to_node, edges_from_node)

	return grid_to_node[(500, 500)].bestdist
end

println(part1())
println(part2())