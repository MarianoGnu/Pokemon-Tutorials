
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
	else:
		if (Input.is_action_pressed("up")):
			moving = Vector2(0,-16)
			anim.play("up")
		elif (Input.is_action_pressed("down")):
			moving = Vector2(0,16)
			anim.play("down")
		elif (Input.is_action_pressed("left")):
			moving = Vector2(-16,0)
			anim.play("left")
		elif (Input.is_action_pressed("right")):
			moving = Vector2(16,0)
			anim.play("right")
