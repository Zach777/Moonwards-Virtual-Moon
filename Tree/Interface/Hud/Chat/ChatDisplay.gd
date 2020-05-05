"""
 This shows the chat history.
"""
extends RichTextLabel


func add_message(sender : EntityData, new_message : String ) -> void :
	newline()
	
	#Format the text so that is displays the username along with it.
	var username : String = sender.entity_name
	new_message = "[color=#00FF1B]"+username+"[/color] " + new_message
	
	#warning-ignore:return_value_discarded
	append_bbcode(new_message)
