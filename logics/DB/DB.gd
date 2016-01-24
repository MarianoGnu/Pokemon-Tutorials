
extends Node

export(String,MULTILINE) var pokedex = ""
export(String,MULTILINE) var pokemon_types = ""
export(String,MULTILINE) var pokemon_moves = ""

var pokemons = []
var types = []
var moves = []

func _ready():
	var dummy = Node.new()
	pokemons.push_back(dummy)
	types.push_back(dummy)
	moves.push_back(dummy)
	var pkm_container = get_node("pokemons")
	for pkm in pkm_container.get_children():
		pokemons.push_back(pkm)
	var type_container = get_node("pokemon_types")
	for type in type_container.get_children():
		types.push_back(type)
	var move_container = get_node("pokemon_moves")
	for move in move_container.get_children():
		moves.push_back(move)


