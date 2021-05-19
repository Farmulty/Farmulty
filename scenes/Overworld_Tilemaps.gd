extends CanvasLayer

var x: int = 100
var y: int = 100

func plant_randomly():
	var flowers = get_node("Flowers")

func _ready():
	plant_randomly()