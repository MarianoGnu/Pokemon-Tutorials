
extends CanvasLayer

var msg

func _ready():
	msg=get_node("MSG")

func show_msg(text):
	msg.show_msg(text)


