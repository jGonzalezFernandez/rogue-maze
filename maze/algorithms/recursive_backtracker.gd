class_name RecursiveBacktracker

static func filter_unvisited_neighbours(neighbours: Array, visited_cells: Array) -> Array:
	var unvisited = []
	for cell in neighbours:
		if !visited_cells.has(cell):
			unvisited.append(cell)
	return unvisited

static func apply_algorithm(maze) -> void:
	var visited_cells = []
	var stack = [maze.get_random_cell()]
	
	while !stack.empty():
		var current_cell = stack.back()
		visited_cells.append(current_cell)
		var candidate_neighbours = filter_unvisited_neighbours(maze.get_neighbours_of(current_cell), visited_cells)
		if !candidate_neighbours.empty():
			var random_candidate = Utils.get_random_elem(candidate_neighbours)
			maze.link_cells(current_cell, random_candidate)
			stack.push_back(random_candidate)
		else:
			stack.pop_back()
