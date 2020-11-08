class_name Cell

var id: int
var row: int
var column: int
var walls: Dictionary
var link_count: int # better performance than iterating the walls to count the false values

func _init(id: int, row: int, column: int) -> void:
	self.id = id
	self.row = row
	self.column = column
	walls = {"N": true, "S": true, "E": true, "W": true}
	link_count = 0
