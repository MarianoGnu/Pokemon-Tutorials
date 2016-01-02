
extends KinematicBody2D

const SPEED = 20

var moving = Vector2()
var anim

func _ready():
	anim=get_node("anim")
	set_fixed_process(true)

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
	if (Input.is_action_pressed("ui_cancel") && !GUI.is_visible()):
		GUI.show_msg("¡Hola a todos!\n¡Bienvenidos al\nmundo de POKÉMON!\n¡Me llamo OAK!\n¡Pero la gente me llama\nel PROFESOR POKÉMON!")
	if (Input.is_action_pressed("ui_page_up") && !GUI.is_visible()):
		GUI.show_options()