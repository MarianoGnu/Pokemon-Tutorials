
extends Panel


export(StyleBox) var style_selected
export(StyleBox) var style_empty

onready var entries = [get_node("fight"),get_node("item"),get_node("pokemon"),get_node("run")]

var index = 0

var signals = ["fight","item","pokemon","run"]

func _init():
	for sig in signals:
		add_user_signal(sig)

func _ready():
	hide()
	set_process(true)
	

func _process(delta):
	if (!is_visible()):
		return
	
	if (INPUT.up.is_action_just_pressed()):
		if (index == 1 || index == 3):
			index -=1
			update_styles()
	if (INPUT.down.is_action_just_pressed()):
		if (index == 0 || index == 2):
			index +=1
			update_styles()
	if (INPUT.right.is_action_just_pressed()):
		if (index == 0 || index == 1):
			index +=2
			update_styles()
	if (INPUT.left.is_action_just_pressed()):
		if (index == 2 || index == 3):
			index -=2
			update_styles()
	if (INPUT.ui_accept.is_action_just_pressed()):
		emit_signal(signals[index])
	

func update_styles():
	for p in range(entries.size()):
		if (p==index):
			entries[p].add_style_override("panel", style_selected)
		else:
			entries[p].add_style_override("panel",style_empty)


