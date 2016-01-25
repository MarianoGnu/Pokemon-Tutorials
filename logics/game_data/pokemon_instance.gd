
extends Node

var pkm_id = 0
var nickname = "" setget set_nick,get_nick
var level = 1
var hp = 1
var max_hp = 1
var status = CONST.STATUS_OK
var attack = 1
var speed = 1
var defense = 1
var special = 1
var dni = 45645634567
var original_trainer = ""
var expecience = 0
var to_next_level = 250

class move_instance:
	var id = 1
	var pp = 5
	var max_pp = 5
	var mod_pp = 0
	func get_name():
		return DB.moves[id].name
	func get_power():
		return DB.moves[id].power
	func get_acuracy():
		return DB.moves[id].acuracy

var movements = []

var mod_attack = 0
var mod_defense = 0
var mod_speed = 0
var mod_hp = 0
var mod_special = 0

func _ready():
	# Initialization here
	pass

func set_nick(value):
	nickname = value

func get_nick():
	if (nickname == ""):
		return DB.pokemons[pkm_id].name
	else:
		return nickname
