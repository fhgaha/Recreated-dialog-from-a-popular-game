@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCDetective := preload("res://game/characters/detective/character_detective.gd")
const PCWorkingClassWoman := preload("res://game/characters/working_class_woman/character_working_class_woman.gd")
const PCNarrator := preload("res://game/characters/narrator/character_narrator.gd")
# ---- classes

# nodes ----
var Detective: PCDetective : get = get_Detective
var WorkingClassWoman: PCWorkingClassWoman : get = get_WorkingClassWoman
var Narrator: PCNarrator : get = get_Narrator
# ---- nodes

# functions ----
func get_Detective() -> PCDetective: return super.get_runtime_character("Detective")
func get_WorkingClassWoman() -> PCWorkingClassWoman: return super.get_runtime_character("WorkingClassWoman")
func get_Narrator() -> PCNarrator: return super.get_runtime_character("Narrator")
# ---- functions

