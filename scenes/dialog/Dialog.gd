extends Control

var example_dict = {
	"character": "Mustermann",
	"text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et",
	"is_question": true,
	"input1": {
		"text": "InputText",
		"event": "Event"
	},
	"input2": {
		"text": "InputText2",
		"event": "Event2"
	}
}

func parse(json: Dictionary):
	$Name.text = json["character"]

	for character in json["text"]:
		$Text.text += character
		yield($TextSpeed, "timeout")
		if character != " ":
			$Soundeffect.play()

func clear():
	$Name.text = ""
	$Text.text = ""

func _ready():
	clear()
	parse(example_dict)