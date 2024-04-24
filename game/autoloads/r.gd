@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRBookstoreFront := preload("res://game/rooms/bookstore_front/room_bookstore_front.gd")
# ---- classes

# nodes ----
var BookstoreFront: PRBookstoreFront : get = get_BookstoreFront
# ---- nodes

# functions ----
func get_BookstoreFront() -> PRBookstoreFront: return super.get_runtime_room("BookstoreFront")
# ---- functions

