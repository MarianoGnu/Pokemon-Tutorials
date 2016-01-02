
extends Panel

export(String,MULTILINE) var msg = "¡Hola a todos!\n¡Bienvenidos al\nmundo de POKÉMON!\n¡Me llamo OAK!\n¡Pero la gente me llama\nel PROFESOR POKÉMON!"

var label
var next
var timer

func _ready():
	label = get_node("Label")
	next = get_node("next")
	timer = get_node("Timer 2")
	hide()

func show_msg(text):
#	text = ""
	label.set_text(text)
	if (text.empty()):
		hide()
		return
	show()
	label.set_lines_skipped(0)
	label.set_percent_visible(0)
	var percent_per_char = 1.0/float(text.length())
	var current = -1
	var eol1=-1
	var eol2=-1
	var skp=-1
	while (current < text.length()-1):
		current+=1
		label.set_percent_visible(percent_per_char*float(current-eol1))
		if (text[current]=='\n'):
			if (skp >= 0):
				next.show()
				while (!Input.is_action_pressed("ui_accept")):
					yield(get_tree(), "idle_frame")
				next.hide()
			skp+=1
			eol1=eol2
			eol2=current-1
			label.set_lines_skipped(skp)
			label.set_percent_visible(percent_per_char*float(current-eol1))
		timer.start()
		yield(timer, "timeout")
	next.show()
	while (!Input.is_action_pressed("ui_accept")):
		yield(get_tree(), "idle_frame")
	next.hide()
	hide()
