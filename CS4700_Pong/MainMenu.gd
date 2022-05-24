extends MarginContainer

const clone_scene = preload("res://clone.tscn")
const variant_scene = preload("res://variant.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var soundStream: AudioStreamPlayer = AudioStreamPlayer.new()
var soundManager: SoundManager = SoundManager.new()

var current_selection = 0

func _ready():
	set_current_selection(0)
	soundStream.name = "SoundStream"
	soundStream.add_child(soundManager)
	add_child(soundStream)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:	
		soundManager.playSelection()
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:	
		soundManager.playSelection()
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		soundManager.playSelection()
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(clone_scene.instance())
		queue_free()
	elif _current_selection == 1:
		get_parent().add_child(variant_scene.instance())
		queue_free()
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
