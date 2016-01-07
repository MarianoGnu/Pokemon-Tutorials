
extends Panel

export(StyleBox) var style_selected
export(StyleBox) var style_empty

onready var entries = [get_node("VBoxContainer/pokedex"),get_node("VBoxContainer/pokemon"),get_node("VBoxContainer/item"),get_node("VBoxContainer/player"),get_node("VBoxContainer/save"),get_node("VBoxContainer/option"),get_node("VBoxContainer/exit")]

var signals = ["pokedex","pokemon","item","player","save","option","exit"]

func _init():
	add_user_signal("pokedex")
	add_user_signal("pokemon")
	add_user_signal("item")
	add_user_signal("player")
	add_user_signal("save")
	add_user_signal("option")
	add_user_signal("exit")

func _ready():
	hide()
	connect("exit", self, "hide")
	set_process(true)

var index = 0

func _process(delta):
	if (INPUT.down.is_action_just_pressed()):
		var i = index
		while (i < entries.size()-1):
			i+=1
			if (entries[i].is_visible()):
				index=i
				break
		update_styles()
	if (INPUT.up.is_action_just_pressed()):
		var i = index
		while (i > 0):
			i-=1
			if (entries[i].is_visible()):
				index=i
				break
		update_styles()
	
	if (INPUT.ui_accept.is_action_just_pressed()):
		emit_signal(signals[index])
	if (INPUT.ui_cancel.is_action_just_pressed()):
		hide()

func update_styles():
	for p in range(entries.size()):
		if (p==index):
			entries[p].add_style_override("panel", style_selected)
		else:
			entries[p].add_style_override("panel",style_empty)