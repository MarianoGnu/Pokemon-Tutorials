
extends Node

export(float) var time
var t

func _init():
	add_user_signal("finished")

func _ready():
	t = get_node("Timer")

func run():
	t.set_wait_time(time)
	t.start()
	yield(t,"timeout")
	emit_signal("finished")
