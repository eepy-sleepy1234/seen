extends MarginContainer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var old_guy: Node2D = $"../../old guy"
@onready var textlabel: Label = $"../textbox/MarginContainer/HBoxContainer/Label"
@onready var namelabel: Label = $"../namebox/MarginContainer/HBoxContainer/Label"

var text = ""
var open = false
var name1 = ""

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if (not old_guy.player_in_range) and open:
		close_box()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if not open:
			if old_guy.player_in_range:
				textlabel.text = ""
				text = "hi i am super cool old ghost guy. i think you are a ghost bro"
				name1 = "Super Cool Old Ghost Guy"
				open_box()
				await get_tree().create_timer(0.5).timeout
				type_words()
		else:
			close_box()

func open_box():
	animation.play("open")
	open = true
func close_box():
	animation.play("close")
	open = false

func type_words():
	if name1 != "":
		namelabel.text = name1
	if text != "":
		for i in text:
			textlabel.text += i
			if i != ".":
				await get_tree().create_timer(0.05).timeout
			elif i == " ":
				await get_tree().create_timer(0.01).timeout
			else:
				await get_tree().create_timer(0.2).timeout
