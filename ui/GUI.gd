
extends CanvasLayer

onready var msg = get_node("MSG")
onready var options = get_node("OPTIONS")

func _ready():
	options.connect("text_speed_changed", self, "_on_text_speed_changed")

func show_msg(text):
	msg.show_msg(text)

func show_options():
	options.show()

func is_visible():
	return msg.is_visible() || options.is_visible()

func _on_text_speed_changed(speed):
	get_node("MSG/Timer 2").set_wait_time(CONST.TEXT_SPEEDS[speed])