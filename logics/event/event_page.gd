
extends Node

func _init():
	add_user_signal("finished")

func run():
	for cmd in get_children():
		if (cmd.get_name().begins_with("cmd_change_page")):
			get_parent().get_parent().set_page(get_parent().get_child(cmd.page))
		else:
			cmd.run()
			yield(cmd, "finished")
	emit_signal("finished")

