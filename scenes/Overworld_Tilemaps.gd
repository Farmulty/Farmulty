extends CanvasLayer

var flower_amount: int = 220
var grass_amount: int = 30

var x_r: int = 70
var y_r: int = 50

func plant_randomly():
	randomize()

	var flowers = get_node("Flowers")

	for flower in range(flower_amount + 1):
		var x = randi() % x_r
		var y = randi() % y_r
		var type = randi() % 4

		flowers.set_cell(x, y, 16, false, false, false, Vector2(type, 1))

func _ready():
	plant_randomly()
