extends CanvasLayer

var flower_amount: int = 350
var grass_amount: int = 450

var x_r: int = 70
var y_r: int = 50

func plant_randomly():
	var amount_each: int
	var total_types: int

	randomize()

	var flowers = get_node("Flowers")

	for kind in [0, 1]: # 1 -> Flower, 0 -> Grass. Add more if needed!
		match kind:
			0:
				amount_each = grass_amount
				total_types = 3
			1:
				amount_each = flower_amount
				total_types = 4

		for _i in range(amount_each + 1):
			var x = randi() % x_r
			var y = randi() % y_r
			var type = randi() % total_types

			flowers.set_cell(x, y, 16, false, false, false, Vector2(type, kind))

func _ready():
	plant_randomly()
