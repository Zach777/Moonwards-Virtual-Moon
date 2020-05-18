extends Area

"""
	Casts to the direction the player is looking.
	When within a given range of an interactable,
	the player will be told of the opportunity to
	interact with the object.
	
	Please note: Anything marked with the comment TEMPCAMERA is meant to 
	be replaced in the future when I am made to work outside of the player. 
"""

#This is what I pass as the interactor.
export var user : NodePath = get_path()

signal interact_possible(string_describing_potential_interact)

#This is show I will not spam a signal when I have potential interacts.
var collider : Area = null
var previous_collider : Area = null


#Determine when I have touched an interactable.
#warning-ignore:unused_argument
func _physics_process(delta : float) -> void:
	#Get the interactable I am colliding with.
	var closest_body : Area = null
	var closest_body_distance : float = 99999999999.0
	for body in get_overlapping_areas() :
		var position_from_me : float
		position_from_me = (global_transform.origin - body.global_transform.origin).length()
		#Determine if the new body is closer.
		if position_from_me < closest_body_distance :
			closest_body_distance = position_from_me
			closest_body = body
			collider = closest_body

	#Exit if I am not touching anything.
	if closest_body == null :
		#Hide interactdisplay if I had been touching something previously.
		collider = null
		previous_collider = null
		hide_display()
		return
	
	#Return the interactable's name and notify listener's of it.
	if previous_collider != collider :
		var interact_info : String = collider.get_info()
		emit_signal("interact_possible", interact_info)
		get_tree().call_group("InteractDisplay", "show_interact_info", collider.get_info())
		previous_collider = collider
	
	#Interact with the interactable if I am told to.
	#TODO: This assumes I am a part of the player. Make this implementation agnostic.
	if Input.is_action_just_pressed("use") :
		#Player wants to interact with the collider.
		collider.interact_with(get_node(user))

#Hide the interact display.
func hide_display() -> void :
	get_tree().call_group("InteractDisplay", "hide")
