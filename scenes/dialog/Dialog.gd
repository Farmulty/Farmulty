extends Control

var example_dict = {
	"character": "Mustermann",
	"text": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et",
	"is_question": true,
	"button_amount": 3,
	"input1": {
		"text": "InputText",
	},
	"input2": {
		"text": "InputText2",
	},
	"input3": {
		"text": "InputText3",
	}
}

func parse(json: Dictionary):
	var button_amount: int
	var cnt: VBoxContainer

	$Name.text = json["character"]

	if json["is_question"]:
		cnt = get_node("Container")

		button_amount = json["button_amount"]

	for i in range(1, button_amount + 1):
		var bt: Button = cnt.get_node("Button" + str(i))

		bt.text = json["input" + str(i)]["text"]
		bt.show()

	for character in json["text"]:
		$Text.text += character
		yield($TextSpeed, "timeout")
		if character != " ":
			$Soundeffect.play()

func clear():
	$Name.text = ""
	$Text.text = ""
	
	var cnt = get_node("Container")
	cnt.get_node("Button1").hide()
	cnt.get_node("Button2").hide()
	cnt.get_node("Button3").hide()

func _ready():
	clear()
	parse(example_dict)