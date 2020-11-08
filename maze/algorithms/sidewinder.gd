class_name Sidewinder

static func close_run(run: Array, maze) -> void:
	if !run.empty():
		var random_candidate = Utils.get_random_elem(run)
		maze.link_cells(random_candidate, maze.get_north_cell_of(random_candidate))
		run.clear()

static func apply_algorithm(maze) -> void:
	var run = []
	
	for row in maze.ROWS:
		for cell in maze.indexed_cells[row]:
			
			if maze.north_exists(cell):
				run.append(cell)
			
			match [maze.north_exists(cell), maze.east_exists(cell)]:
				[false, true]:
					maze.link_cells(cell, maze.get_east_cell_of(cell))
				[_, false]:
					close_run(run, maze)
				[true, true]:
					if Utils.fifty_percent_chance(): # randomly close run
						close_run(run, maze)
					else:
						maze.link_cells(cell, maze.get_east_cell_of(cell))
