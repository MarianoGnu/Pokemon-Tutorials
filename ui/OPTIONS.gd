
extends Control

export(StyleBox) var style_selected
export(StyleBox) var style_unselected
export(StyleBox) var style_emty


var text_speeds=[]
var battle_animations=[]
var battle_types=[]

var current_text_speed = CONST.OPTION_TEXT_MEDIUM;
var current_battle_animation = CONST.OPTION_BATTLE_ANIM_ON;
var current_battle_type = CONST.OPTION_BATTLE_TYPE_SHIFT;

var index = 0

func _init():
	var d = {}
	d["name"]="speed"
	d["type"]=TYPE_INT
	add_user_signal("text_speed_changed",[d])
	d["name"]="animations_on"
	add_user_signal("battle_animations_changed",[d])
	d["name"]="battle_type"
	add_user_signal("battle_type_changed",[d])
	add_user_signal("exit")
	

func _ready():
	hide()
	
	text_speeds.push_back(get_node("text_speed/HBoxContainer/fast"))
	text_speeds.push_back(get_node("text_speed/HBoxContainer/medium"))
	text_speeds.push_back(get_node("text_speed/HBoxContainer/slow"))
	
	battle_animations.push_back(get_node("battle_animation/HBoxContainer1/on"))
	battle_animations.push_back(get_node("battle_animation/HBoxContainer1/off"))
	
	battle_types.push_back(get_node("battle_type/HBoxContainer2/shift"))
	battle_types.push_back(get_node("battle_type/HBoxContainer2/set"))
	
	var f = File.new()
	if f.file_exists("user://options.json"):
		f.open("user://options.json",File.READ)
		var json = f.get_as_text()
		var data = {}
		data.parse_json(json)
		current_text_speed = data["speed"]
		current_battle_type = data["battle_type"]
		current_battle_animation = data["battle_animation"]
		f.close()
	
	emit_signal("text_speed_changed", current_text_speed)
	emit_signal("battle_animations_changed", current_battle_animation)
	emit_signal("battle_type_changed", current_battle_type)
	update_styles()
	set_process(true)

func save_data():
	var f = File.new()
	f.open("user://options.json",File.WRITE)
	var d = {}
	d["speed"] = current_text_speed
	d["battle_type"] = current_battle_type
	d["battle_animation"] = current_battle_animation
	var json = d.to_json()
	f.store_string(json)
	f.close()

func update_styles():
	for p in range(3):
		if (current_text_speed==p):
			var style = style_selected
			if (index != 0):
				style = style_unselected
			text_speeds[p].add_style_override("panel",style)
		else:
			text_speeds[p].add_style_override("panel",style_emty)
	for p in range(2):
		if (current_battle_animation==p):
			var style = style_selected
			if (index != 1):
				style = style_unselected
			battle_animations[p].add_style_override("panel",style)
		else:
			battle_animations[p].add_style_override("panel",style_emty)
	for p in range(2):
		if (current_battle_type==p):
			var style = style_selected
			if (index != 2):
				style = style_unselected
			battle_types[p].add_style_override("panel",style)
		else:
			battle_types[p].add_style_override("panel",style_emty)
	if (index == 3):
		get_node("cancel").add_style_override("panel",style_selected)
	else:
		get_node("cancel").add_style_override("panel",style_unselected)
	

func _process(delta):
	if (INPUT.down.is_action_just_pressed()):
		if (index < 3):
			index+=1
			update_styles()
	elif (INPUT.up.is_action_just_pressed()):
		if (index > 0):
			index-=1
			update_styles()
	elif (INPUT.right.is_action_just_pressed()):
		if (index==0):
			if (current_text_speed < CONST.OPTION_TEXT_SLOW):
				current_text_speed+=1
				emit_signal("text_speed_changed",current_text_speed)
				update_styles()
		elif (index==1):
			if (current_battle_animation < CONST.OPTION_BATTLE_ANIM_OFF):
				current_battle_animation+=1
				emit_signal("battle_animations_changed",current_battle_animation)
				update_styles()
		elif (index==2):
			if (current_battle_type < CONST.OPTION_BATTLE_TYPE_SET):
				current_battle_type+=1
				emit_signal("battle_type_changed",current_battle_type)
				update_styles()
		save_data()
	elif (INPUT.left.is_action_just_pressed()):
		if (index==0):
			if (current_text_speed > 0):
				current_text_speed-=1
				emit_signal("text_speed_changed",current_text_speed)
				update_styles()
		elif (index==1):
			if (current_battle_animation > 0):
				current_battle_animation-=1
				emit_signal("battle_animations_changed",current_battle_animation)
				update_styles()
		elif (index==2):
			if (current_battle_type > 0):
				current_battle_type-=1
				emit_signal("battle_type_changed",current_battle_type)
				update_styles()
		save_data()
	elif (INPUT.ui_cancel.is_action_just_pressed()):
		emit_signal("exit")
		hide()
	elif (INPUT.ui_accept.is_action_just_pressed()):
		if (index==3):
			emit_signal("exit")
			hide()