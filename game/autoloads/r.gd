@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRBookstoreFront := preload("res://game/rooms/bookstore_front/room_bookstore_front.gd")
const PREnd := preload("res://game/rooms/end/room_end.gd")
const PRStart := preload("res://game/rooms/start/room_start.gd")
# ---- classes

# nodes ----
var BookstoreFront: PRBookstoreFront : get = get_BookstoreFront
var End: PREnd : get = get_End
var Start: PRStart : get = get_Start
# ---- nodes

# functions ----
func get_BookstoreFront() -> PRBookstoreFront: return super.get_runtime_room("BookstoreFront")
func get_End() -> PREnd: return super.get_runtime_room("End")
func get_Start() -> PRStart: return super.get_runtime_room("Start")
# ---- functions

