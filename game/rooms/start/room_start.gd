@tool
extends PopochiuRoom

const Data := preload('room_start_state.gd')

var state: Data = load('res://game/rooms/start/room_start.tres')


#region Virtual ####################################################################################
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	A.mx_sad.play(0, 0)
	pass


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	# You can use await E.queue([]) to excecute a sequence of instructions
	$"../E/GraphicInterfaceLayer/GraphicInterface/InventoryBar".hide()
	$"../E/GraphicInterfaceLayer/GraphicInterface/SettingsBar".hide()
	
	#await E.wait(0.5)
	E.text_speed = 1.2
	#PopochiuGlobals.ignore_click = true
	await C.Narrator.say("[center][font=%s][color=%s]%s[/color][/font][/center]" 
	% [PopochiuGlobals.ANTIQUITY_PRINT, "#35b7a0", PopochiuGlobals.game_name])
	
	#await C.Narrator.say("[center][font=%s]%s[/font][/center]" 
	#% [PopochiuGlobals.ANTIQUITY_PRINT, PopochiuGlobals.game_name])
	
	#PopochiuGlobals.ignore_click = false
	E.text_speed = PopochiuConfig.get_text_speed()
	
	await E.wait(0.5)
	E.goto_room("BookstoreFront")
	pass


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


#endregion
