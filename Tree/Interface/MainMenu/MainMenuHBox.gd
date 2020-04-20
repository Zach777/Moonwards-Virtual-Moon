extends HBoxContainer


onready var START_GAME : Button = get_node("VBoxContainer/StartGame") setget _do_not_set_buttons
onready var SETTINGS : Button = get_node("VBoxContainer/Settings") setget _do_not_set_buttons
onready var OTHER : Button = get_node("VBoxContainer/Other") setget _do_not_set_buttons


func _ready() -> void :
	get_node("VBoxContainer/StartGame").grab_focus()

#This creates the graphical effect when a button is highlighted.
func _create_button_effect(button : Button) -> void :
	pass

#This forbids the onready buttons from being set since they act as constants.
#warning-ignore:unused_argument
func _do_not_set_buttons(new_value) -> void :
	assert(true == false)

#The bottom three methods are in charge of making the special
#effects appear for their appropriate button.
func _on_Other_highlighted() -> void :
	_create_button_effect(OTHER)

func _on_Settings_highlighted() -> void :
	_create_button_effect(SETTINGS)

func _on_StartGame_highlighted() -> void :
	_create_button_effect(START_GAME)
