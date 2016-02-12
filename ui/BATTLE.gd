
extends Control

var enemy
var active_pokemon = null setget set_active_pokemon,get_active_pokemon

onready var enemy_sprite = get_node("enemy")
onready var player_sprite = get_node("player")
onready var commands = get_node("commands")
onready var attack_list = get_node("attack_list")
onready var anim = get_node("anim")

func _ready():
	hide()
	commands.connect("fight", commands, "hide")
	commands.connect("fight", attack_list, "show")
	attack_list.connect("cancel", commands, "show")
	attack_list.connect("cancel", attack_list, "hide")
	pass

func set_active_pokemon(pkm):
	active_pokemon = pkm
	if (pkm != null):
		for i in range(4):
			if i < active_pokemon.movements.size():
				attack_list.labels[i].set_text(active_pokemon.movements[i].get_name())
			else:
				attack_list.labels[i].set_text("-")
		attack_list.update_styles()

func get_active_pokemon():
	return active_pokemon

func wild_encounter(pkm_id, level):
	enemy = DB.pokemons[pkm_id].make_wild(level)
	player_sprite.set_frame(0)
	enemy_sprite.set_frame(pkm_id)
	anim.play("wild_start")
	yield(anim, "finished")
	self.active_pokemon = GAME_DATA.party[0]
	var t = Timer.new()
	t.set_wait_time(0.5)
	add_child(t)
	GUI.show_msg(enemy.nickname + " salvaje apareció!", t, "timeout")
	yield(GUI.msg, "text_displayed")
	t.start()
	yield(t,"timeout")
	t.queue_free()
	yield(get_tree(), "idle_frame")
	commands.show()
	