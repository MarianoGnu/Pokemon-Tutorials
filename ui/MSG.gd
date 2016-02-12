
extends Panel

const MAX_CHARS_PER_LINE = 16

export(String,MULTILINE) var msg = "¡Hola a todos!\n¡Bienvenidos al\nmundo de POKÉMON!\n¡Me llamo OAK!\n¡Pero la gente me llama\nel PROFESOR POKÉMON!"
var label
var next
var timer

func _init():
	add_user_signal("text_displayed")

func _ready():
	label = get_node("Label")
	next = get_node("next")
	timer = get_node("Timer 2")
	hide()

func show_msg(text="", obj = null, sig = ""):
	if (text.empty()):
		hide()
		return
	text = autoclip(text)
	label.set_text(text)
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
	emit_signal("text_displayed")
	if (obj != null and sig!=""):
		yield(obj,sig)
	next.show()
	while (!Input.is_action_pressed("ui_accept")):
		yield(get_tree(), "idle_frame")
	next.hide()
	hide()

func autoclip(text=""):
	var lines = [""]
	for p in text.split("\n", false):
		for w in p.split(" ", false):
			if (lines[lines.size()-1].length()+w.length()+1 <= MAX_CHARS_PER_LINE):
				if lines[lines.size()-1] == "":
					lines[lines.size()-1] = w
				else:
					lines[lines.size()-1] += " "+w;
			else:
				lines.append(w)
	text = ""
	for l in range(lines.size()-1):
		text += lines[l] + "\n"
	text += lines[lines.size()-1]
	
	return text
