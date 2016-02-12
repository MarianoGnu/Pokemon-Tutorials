
extends Node2D

onready var anim = get_node("anim")
onready var event = get_node("event")
onready var rays = [get_node("up"),get_node("down"),get_node("left"),get_node("right")]

func _init():
	add_to_group("movable")

func _ready():
	get_node("event").add_to_group("npc")
	move(CONST.LEFT)

func move(direction):
	if (rays[direction].is_colliding()):
		return;
	if (direction==CONST.UP):
		set_pos(get_pos()+Vector2(0,-16))
		anim.play("up")
		anim.seek(0, true)
	elif (direction==CONST.DOWN):
		set_pos(get_pos()+Vector2(0,16))
		anim.play("down")
		anim.seek(0, true)
	elif (direction==CONST.LEFT):
		set_pos(get_pos()+Vector2(-16,0))
		anim.play("left")
		anim.seek(0, true)
	elif (direction==CONST.RIGHT):
		set_pos(get_pos()+Vector2(16,0))
		anim.play("right")
		anim.seek(0, true)

func add_exeception(who):
	for ray in rays:
		ray.add_exception(who)

func remove_exception(who):
	for ray in rays:
		ray.remove_exception(who)
