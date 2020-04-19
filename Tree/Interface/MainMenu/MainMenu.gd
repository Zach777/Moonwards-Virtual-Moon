extends CanvasLayer
"""
	MainMenu Singleton Scene Script
"""

onready var tabs: TabContainer = $"Top/Tabs"


#Show the main menu.
func show() -> void:
	for i in get_children():
		if i is Control:
			i.visible = true

#Hide the main menu.
func hide() -> void:
	for i in get_children():
		if i is Control:
			i.visible = false

func _on_bLocalGame_pressed() -> void:
	tabs.current_tab = 3

func _on_Quit_pressed() -> void:
#	Options.save_user_settings()
	get_tree().quit()

func _on_bStart_pressed() -> void:
	#This is a temporary button with temporary code.
	return
#	var test_scene = preload("res://_tests/NewDemo/TestScene.tscn")
#	get_tree().change_scene_to(test_scene)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Toggle the About scene.
func _on_About_pressed():
	var about : PanelContainer = get_node("HBoxContainer/About")
	var panel : Panel = get_node("HBoxContainer/Panel")
	var v_box : VBoxContainer = get_node("HBoxContainer/VBoxContainer")
	var about_button : Button = get_node("About")
	
	if about.visible:
		about.hide()
		panel.show()
		v_box.show()
		about_button.text = "About"
	
	else:
		panel.hide()
		v_box.hide()
		about.show()
		about_button.text = "Hide About"

func _on_StartGame_pressed():
	pass # Replace with function body.
