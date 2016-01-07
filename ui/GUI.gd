
extends CanvasLayer

onready var msg = get_node("MSG")
onready var options = get_node("OPTIONS")
onready var menu = get_node("MAIN_MENU")

func _ready():
	menu.connect("option", self, "_on_menu_options")
	options.connect("text_speed_changed", self, "_on_text_speed_changed")

func show_msg(text):
	msg.show_msg(text)

func show_options():
	options.show()

func show_menu():
	menu.show()

func is_visible():
	return msg.is_visible() || options.is_visible() || menu.is_visible()

func _on_text_speed_changed(speed):
	get_node("MSG/Timer 2").set_wait_time(CONST.TEXT_SPEEDS[speed])

func _on_menu_options():
	menu.hide()
	menu.set_process(false)
	show_options()
	yield(options, "exit")
	menu.show()
	menu.set_process(true)