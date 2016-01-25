
extends Control

var enemy

onready var enemy_sprite = get_node("enemy")
onready var player_sprite = get_node("player")
onready var anim = get_node("anim")

func _ready():
	hide()
	pass

func wild_encounter(pkm_id, level):
	enemy = DB.pokemons[pkm_id].make_wild(level)
	player_sprite.set_frame(0)
	enemy_sprite.set_frame(pkm_id)
	anim.play("wild_start")
	yield(anim, "finished")
	GUI.show_msg(enemy.nickname + " salvaje\napareció!")