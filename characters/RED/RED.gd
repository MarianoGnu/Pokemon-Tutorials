
extends KinematicBody2D

const SPEED = 20

var moving = Vector2()
var anim
var can_interact = false setget set_can_interact,get_can_interct

func _init():
	Globals.set("player", self)

func _ready():
	anim=get_node("anim")
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	if (moving.length_squared() == 0):
		if (INPUT.ui_start.is_action_just_pressed() && !GUI.is_visible()):
			GUI.show_menu()

func _fixed_process(delta):
	if (moving.length_squared() > 0):
		var movement = moving.normalized()*delta*SPEED;
		if (movement.length_squared() > moving.length_squared()):
			movement=moving
		moving-=movement
		move(movement)
		if (moving.length_squared() == 0):
			var p = get_pos()
			p=Vector2(round(p.x),round(p.y))
			set_pos(p)
	else:
		if (!can_interact):
			return
		if (Input.is_action_pressed("up") && !GUI.is_visible()):
			moving = Vector2(0,-16)
			anim.play("up")
		elif (Input.is_action_pressed("down") && !GUI.is_visible()):
			moving = Vector2(0,16)
			anim.play("down")
		elif (Input.is_action_pressed("left") && !GUI.is_visible()):
			moving = Vector2(-16,0)
			anim.play("left")
		elif (Input.is_action_pressed("right") && !GUI.is_visible()):
			moving = Vector2(16,0)
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