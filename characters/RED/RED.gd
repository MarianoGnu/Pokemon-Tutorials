
extends Node2D

const SPEED = 2

var anim
var can_interact = true setget set_can_interact,get_can_interct
onready var rays = [get_node("up"),get_node("down"),get_node("left"),get_node("right")]


func _init():
	Globals.set("player", self)

func _ready():
	anim=get_node("anim")
	anim.set_speed(SPEED)
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	if (!anim.is_playing()):
		if (INPUT.ui_start.is_action_just_pressed() && !GUI.is_visible()):
			GUI.show_menu()

func _fixed_process(delta):
	if (anim.is_playing()):
		return;
	else:
		if (!can_interact):
			return
		if (Input.is_action_pressed("up") && !GUI.is_visible()):
			if (rays[CONST.UP].is_colliding()):
				anim.play("up_hit")
			else:
				set_pos(get_pos()+Vector2(0,-16))
				anim.play("up")
		elif (Input.is_action_pressed("down") && !GUI.is_visible()):
			if (rays[CONST.DOWN].is_colliding()):
				anim.play("down_hit")
			else:
				set_pos(get_pos()+Vector2(0,16))
				anim.play("down")
		elif (Input.is_action_pressed("left") && !GUI.is_visible()):
			if (rays[CONST.LEFT].is_colliding()):
				anim.play("left_hit")
			else:
				set_pos(get_pos()+Vector2(-16,0))
				anim.play("left")
		elif (Input.is_action_pressed("right") && !GUI.is_visible()):
			if (rays[CONST.RIGHT].is_colliding()):
				anim.play("right_hit")
			else:
				set_pos(get_pos()+Vector2(16,0))
				anim.play("right")
		elif (INPUT.ui_accept.is_action_just_pressed() && !GUI.is_visible()):
			pass
#	if (Input.is_action_pressed("ui_cancel") && !GUI.is_visible()):
#		GUI.show_msg("¡Hola a todos!\n¡Bienvenidos al\nmundo de POKÉMON!\n¡Me llamo OAK!\n¡Pero la gente me llama\nel PROFESOR POKÉMON!")

func set_can_interact(can):
	set_process(can)
	can_interact = can

func get_can_interct():
	return can_interact