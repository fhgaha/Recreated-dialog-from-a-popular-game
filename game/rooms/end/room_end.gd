@tool
extends PopochiuRoom

const Data := preload('room_end_state.gd')

var state: Data = load('res://game/rooms/end/room_end.tres')


#region Virtual ####################################################################################
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	pass


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	# You can use await E.queue([]) to excecute a sequence of instructions
	const ANTIQUITY_PRINT = "res://assets/fonts/antiquity-print.ttf"
	var green = "#5d946e"
	var game_name = "A Recreated Dialog from a Popular Game with an Unnecessary Long Name"
	await E.wait(0.5)
	await C.Narrator.say("Thanks for playing\n[font=%s][color=%s]%s[/color][/font]" % [ANTIQUITY_PRINT, green, game_name])
	pass

# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


#endregion
