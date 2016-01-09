
extends Node

export(String, MULTILINE) var text = ""

func _init():
	add_user_signal("finished")

func run():
	GUI.show_msg(text)
	while (GUI.is_visible()):
		yield(get_tree(),"idle_frame")
	emit_signal("finished")
	


