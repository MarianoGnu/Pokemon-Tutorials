
extends Area2D

var current_page
var player

func set_page(page):
	current_page = page

func _ready():
	player=Globals.get("player")
	current_page = get_node("pages").get_child(0)


func exec():
	player.can_interact = false
	current_page.run()
	yield(current_page, "finished")
	player.can_interact = true


