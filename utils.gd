class_name Utils

static func random_int(max_exclusive: int, min_inclusive: int = 0) -> int:
	return randi() % (max_exclusive - min_inclusive) + min_inclusive

static func twenty_five_percent_chance() -> bool:
	return random_int(4) == 0

static func fifty_percent_chance() -> bool:
	return random_int(2) == 0

static func get_random_elem(array: Array):
	return array[random_int(array.size())]

static func pop_random_elem(array: Array):
	array.shuffle()
	return array.pop_back()

static func rounded_division(dividend: int, divisor: float) -> int:
	return int(round(dividend / divisor))

static func rounded_half(value: int) -> int:
	return rounded_division(value, 2.0)

static func half(value: int) -> float:
	return value / 2.0
