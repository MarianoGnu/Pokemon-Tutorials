
extends Node

var action = ""

var prev_state = false
var curr_state = false

func _ready():
	action = get_name()
	set_process(true)

func _process(delta):
	prev_state = curr_state
	curr_state = Input.is_action_pressed(action)
	

func is_action_just_pressed():
	return !prev_state && curr_state

func is_action_just_released():
	return prev_state && !curr_state