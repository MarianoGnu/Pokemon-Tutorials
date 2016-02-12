
extends CanvasLayer

onready var msg = get_node("MSG")
onready var options = get_node("OPTIONS")
onready var menu = get_node("MAIN_MENU")
onready var battle = get_node("BATTLE")

func _ready():
	menu.connect("option", self, "_on_menu_options")
	options.connect("text_speed_changed", self, "_on_text_speed_changed")

func show_msg(text, obj = null, sig=""):
	msg.show_msg(text,obj,sig)

func show_options():
	options.show()
	options.set_process(true)
	yield(options,"exit")
	options.set_process(false)

func show_menu():
	menu.show()
	menu.set_process(true)
	yield(menu,"exit")
	menu.set_process(false)

func is_visible():
	return msg.is_visible() || options.is_visible() || menu.is_visible() || battle.is_visible()

func _on_text_speed_changed(speed):
	get_node("MSG/Timer 2").set_wait_time(CONST.TEXT_SPEEDS[speed])

func _on_menu_options():
	menu.hide()
	menu.set_process(false)
	show_options()
	yield(options, "exit")
	menu.show()
	menu.set_process(true)

func wild_encounter(id, level):
	battle.show()
	battle.wild_encounter(id, level)