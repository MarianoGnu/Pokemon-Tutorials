
extends Node2D

onready var anim = get_node("anim")
onready var event = get_node("event")
onready var rays = [get_node("up"),get_node("down"),get_node("left"),get_node("right")]

func _ready():
	get_node("event").add_to_group("npc")

func move(direction):
	if (rays[direction].is_colliding()):
		return;
	if (direction==CONST.UP):
		set_pos(get_pos()+Vector2(0,-16))
		anim.play("up")
	elif (direction==CONST.DOWN):
		set_pos(get_pos()+Vector2(0,16))
		anim.play("down")
	elif (direction==CONST.LEFT):
		set_pos(get_pos()+Vector2(-16,0))
		anim.play("left")
	elif (direction==CONST.RIGHT):
		set_pos(get_pos()+Vector2(16,0))
		anim.play("right")
