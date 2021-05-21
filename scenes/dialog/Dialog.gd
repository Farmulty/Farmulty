extends Control

signal button(nr, text)

onready var global = get_node("/root/Global")

var text_to_print: String 

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
	var button_amount: int = 0
	var cnt: VBoxContainer

	$Name.text = json["character"]

	global.in_dialog = true
	global.dialog_started = false

	if json["is_question"]:
		cnt = get_node("Container")

		button_amount = json["button_amount"]

	for i in range(1, button_amount + 1):
		var bt: Button = cnt.get_node("Button" + str(i))

		bt.text = json["input" + str(i)]["text"]
		bt.show()
	
	text_to_print = json["text"]

func start():
	global.dialog_started = true

	for character in text_to_print:
		$Text.text += character
		yield($TextSpeed, "timeout")
		if character != " ":
			$Soundeffect.play()

		if not global.dialog_started:
			clear()
			emit_signal("button", 0, "")

			return

func clear():
	$Name.text = ""
	$Text.text = ""
	
	var cnt = get_node("Container")
	cnt.get_node("Button1").hide()
	cnt.get_node("Button2").hide()
	cnt.get_node("Button3").hide()

	global.in_dialog = false

func _button_pressed(button_nr: String):
	"""Emits signal with button_nr and reference to the button."""
	emit_signal("button", button_nr, $Container.get_node("Button" + button_nr))

	global.in_dialog = false
	clear()

func _ready():
	clear()

	if get_parent().get_parent() == null:
		parse(example_dict)
		start()