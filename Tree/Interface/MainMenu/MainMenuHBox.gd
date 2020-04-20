extends HBoxContainer


onready var START_GAME : Button = get_node("VBoxContainer/StartGame") setget _do_not_set_buttons
onready var SETTINGS : Button = get_node("VBoxContainer/Settings") setget _do_not_set_buttons
onready var OTHER : Button = get_node("VBoxContainer/Other") setget _do_not_set_buttons
onready var PANEL : Panel = get_node("Panel") setget _do_not_set_buttons

#Determines what button to draw from.
onready var current_button : Button = START_GAME

#These are the current surges.
var surges : Array = []

#How fast the surges travel.
const SURGE_SPEED : float = 248.0

#Add a surge to be drawn from the button to the panel.
func _create_surge() -> void :
	var surge : Array = []
	var surge_position : Vector2 = Vector2()
	surge_position.x = current_button.rect_position.x + current_button.rect_size.x
	surge_position.y = current_button.rect_position.y + (current_button.rect_size.y * 0.5)
	surge.append(surge_position)
	
	#Append the new surge to the list of surges.
	surges.append(surge)

func _draw() -> void :
	#Draw a line from the currently highlighted button to the panel.
	var draw_from : Vector2 = Vector2()
	draw_from.x = current_button.rect_position.x + current_button.rect_size.x
	draw_from.y = current_button.rect_position.y + (current_button.rect_size.y * 0.5)
	var draw_to : Vector2 = Vector2()
	draw_to.x = PANEL.rect_position.x
	draw_to.y = draw_from.y
	draw_line(draw_from, draw_to, Color(1,1,1,1), 3.0)
	
	#Animate the surges.
	for surge in surges :
		var rect1 : Rect2 = Rect2(surge[0].x, surge[0].y - 6, 4, 12)
		var rect2 : Rect2 = Rect2(surge[0].x - 6, surge[0].y - 5, 4, 10)
		var rect3 : Rect2 = Rect2(surge[0].x + 6, surge[0].y - 4, 3, 8)
		var rect4 : Rect2 = Rect2(surge[0].x - 11, surge[0].y - 4, 3, 8)
		draw_rect(rect1, Color(1,1,1,1))
		draw_rect(rect2, Color(1,1,1,1))
		draw_rect(rect3, Color(1,1,1,1))
		draw_rect(rect4, Color(1,1,1,1))

#Draw each frame to keep up to date with resolution changes.
#warning-ignore:unused_argument
func _process(delta : float) -> void :
	update()
	
	#Move the surges.
	var remove_surges : Array = []
	for surge in surges :
		surge[0].x += SURGE_SPEED * delta
		
		#This is for freeing the surge if it has reached the panel.
		if surge[0].x >= PANEL.rect_position.x :
			remove_surges.append(surges.find(surge))
	
	#Remove the surges that are past the Panel.
	remove_surges.invert()
	for pos in remove_surges :
		surges.remove(pos)

func _ready() -> void :
	get_node("VBoxContainer/StartGame").grab_focus()

#This forbids the onready buttons from being set since they act as constants.
#warning-ignore:unused_argument
func _do_not_set_buttons(new_value) -> void :
	assert(true == false)

#The bottom three methods are in charge of making the special
#effects appear for their appropriate button.
func _on_Other_highlighted() -> void :
	current_button = OTHER
	_create_surge()

func _on_Settings_highlighted() -> void :
	current_button = SETTINGS
	_create_surge()

func _on_StartGame_highlighted() -> void :
	current_button = START_GAME
	_create_surge()
