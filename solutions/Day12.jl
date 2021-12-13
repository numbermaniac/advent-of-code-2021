struct Node
	name :: String
	size :: String
end

struct Edge
	sideA :: Node
	sideB :: Node
end

issmall(n :: Node) = n.size == "small"
isbig(n :: Node) = n.size == "big"
other(edge :: Edge, node :: Node) = node == edge.sideA ? edge.sideB : node == edge.sideB ? edge.sideA : error("node not on either edge")
isstart(n :: Node) = n.name == "start"
isend(n :: Node) = n.name == "end"
getedges(n :: Node, edges :: Vector{Edge}) = [edge for edge in edges if edge.sideA == n || edge.sideB == n]

function makenode(name :: String)
	size = all(isuppercase(n) for n in name) ? "big" : "small"

	return Node(name, size)
end

function setup()
	edges = Edge[]
	nodes = Node[]
	lines = readlines("inputD12.txt")
	for line in lines
		sideA, sideB = string.(split(line, "-"))

		existingA = [n for n in nodes if n.name == sideA]
		if isempty(existingA)
			nodeA = makenode(sideA)
			push!(nodes, nodeA)
		else
			nodeA = first(existingA)
		end

		existingB = [n for n in nodes if n.name == sideB]
		if isempty(existingB)
			nodeB = makenode(sideB)
			push!(nodes, nodeB)
		else
			nodeB = first(existingB)
		end

		push!(edges, Edge(nodeA, nodeB))
	end

	return (edges, nodes)
end

function part1()
	edges, nodes = setup()

	start = first([n for n in nodes if isstart(n)])
	paths = [[start]]
	finished_paths = Vector{Node}[]

	while !isempty(paths)
		new_paths = Vector{Node}[]
		for path in paths
			current_node = last(path)
			node_edges = getedges(current_node, edges)
			targets = [other(ne, current_node) for ne in node_edges]
			for target in targets
				# decide if valid target
				if !isstart(target) && (isbig(target) || (issmall(target) && !(target in path)))
					new_path = push!(copy(path), target)

					isend(target) ? push!(finished_paths, new_path) : push!(new_paths, new_path)
				end
			end
		end

		paths = copy(new_paths)
	end

	return length(finished_paths)
end

function countdoubledsmallcaves(path :: Vector{Node})
	small_nodes = [node for node in path if issmall(node)]
	return length(small_nodes) - length(Set(small_nodes))
end

function part2()
	edges, nodes = setup()

	start = first([n for n in nodes if isstart(n)])
	paths = [[start]]
	finished_paths = Vector{Node}[]

	while !isempty(paths)
		new_paths = Vector{Node}[]
		for path in paths
			current_node = last(path)
			node_edges = getedges(current_node, edges)
			targets = [other(ne, current_node) for ne in node_edges]
			for target in targets
				# decide if valid target
				small_doubles = countdoubledsmallcaves(path)
				if !isstart(target) && (isbig(target) || (issmall(target) && (small_doubles == 0 || (small_doubles == 1 && !(target in path)))))
					new_path = push!(copy(path), target)

					isend(target) ? push!(finished_paths, new_path) : push!(new_paths, new_path)
				end
			end
		end

		paths = copy(new_paths)
	end

	return length(finished_paths)
end

println(part1())
println(part2())