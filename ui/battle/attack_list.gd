
extends Panel

export(StyleBox) var style_selected
export(StyleBox) var style_empty

onready var entries = [get_node("attack1"),get_node("attack2"),get_node("attack3"),get_node("attack4")]
onready var labels = [get_node("attack1/Label1"),get_node("attack2/Label1"),get_node("attack3/Label1"),get_node("attack4/Label1")]
onready var attack_type = get_node("info/type")
onready var attack_pp = get_node("info/pp")

var index = 0

func _init():
	add_user_signal("attack_selected")
	add_user_signal("cancel")

func _ready():
	hide()
	set_process(true)

func _process(delta):
	if !is_visible():
		return
	if (INPUT.up.is_action_just_pressed()):
		if (index > 0):
			index -=1
			update_styles()
	if (INPUT.down.is_action_just_pressed()):
		if (index < 3):
			index +=1
			update_styles()
	if (INPUT.ui_cancel.is_action_just_pressed()):
		emit_signal("cancel")

func update_styles():
	for p in range(entries.size()):
		if (p==index):
			entries[p].add_style_override("panel", style_selected)
		else:
			entries[p].add_style_override("panel",style_empty)
		var pkm = get_parent().active_pokemon
		if index < pkm.movements.size():
			var movement = pkm.movements[index]
			attack_type.set_text(movement.get_type_name())
			attack_pp.set_text(str(movement.pp)+"/"+str(movement.max_pp))
		else:
			attack_type.set_text("---")
			attack_pp.set_text("-/-")