extends HBoxContainer


onready var START_GAME : Button = get_node("VBoxContainer/StartGame") setget _do_not_set_buttons
onready var SETTINGS : Button = get_node("VBoxContainer/Settings") setget _do_not_set_buttons
onready var OTHER : Button = get_node("VBoxContainer/Other") setget _do_not_set_buttons
onready var PANEL : Panel = get_node("Panel") setget _do_not_set_buttons

#Determines what button to draw from.
onready var current_button : Button = START_GAME

#Wait everyother frame to draw the gfx.
var wait_this_frame : bool = false

func _draw() -> void :
	#For now, draw a line from Start game to the panel.
	var draw_from : Vector2 = Vector2()
	draw_from.x = current_button.rect_position.x + current_button.rect_size.x
	draw_from.y = current_button.rect_position.y + (current_button.rect_size.y * 0.5)
	var draw_to : Vector2 = Vector2()
	draw_to.x = PANEL.rect_position.x
	draw_to.y = draw_from.y
	draw_line(draw_from, draw_to, Color(1,1,1,1), 3.0)

#Draw each frame to keep up to date with resolution changes.
#warning-ignore:unused_argument
func _process(delta : float) -> void :
		update()

func _ready() -> void :
	get_node("VBoxContainer/StartGame").grab_focus()

#This determines what button gets the graphical effect.
func _create_button_effect(button : Button) -> void :
	current_button = button

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
