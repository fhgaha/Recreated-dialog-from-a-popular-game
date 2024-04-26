extends "res://addons/popochiu/engine/objects/graphic_interface/components/dialog_text/dialog_text.gd"


func stop() -> void:
	if PopochiuGlobals.ignore_click:
		return
	
	super()
