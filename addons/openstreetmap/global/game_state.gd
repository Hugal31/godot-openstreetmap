extends Node

const variables_file_name = "user://savedata.bin"
@onready var savegame_key = null#"TW"+OS.get_unique_ID()
var variables = { }

func _ready():
	print("game state ready")
	read()

# user configuration

func get_var(n, d):
	if variables.has(n):
		return variables[n]
	else:
		return d

func set_var(n, v):
	variables[n] = v

func read():
	var f: FileAccess = null
	if savegame_key == null:
		f = FileAccess.open(variables_file_name, FileAccess.READ)
	else:
		f = FileAccess.open_encrypted_with_pass(variables_file_name, FileAccess.READ, savegame_key)
	if f != null:
		variables = f.get_var()

func write():
	var f: FileAccess
	if savegame_key == null:
		f = FileAccess.open(variables_file_name, FileAccess.WRITE)
	else:
		f = FileAccess.open_encrypted_with_pass(variables_file_name, FileAccess.WRITE, savegame_key)
	if f:
		f.store_var(variables)
		f.close()

func reset():
	variables = { }
	write()
