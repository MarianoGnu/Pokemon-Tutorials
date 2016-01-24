
extends Node

export(int) var id = 0
export(String) var name = ""

export(Array) var evol_method = [] #CONST.EVOL_LVL_UP
export(Array) var evol_lvl = []
export(Array) var evol_pokemon_id = []

export(String,MULTILINE) var description = ""

export(Array) var learn_type = []
export(Array) var learn_lvl = []
export(Array) var learn_move_id = []

export(int,"None, Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel, Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy") var type_a
export(int,"None, Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel, Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy") var type_b
export(int) var catch_rate = 0
export(String) var short_desc = ""
export(int) var hp = 0
export(int) var attack= 0
export(int) var defense = 0
export(int) var special = 0
export(int) var speed = 0
export(int) var total = 0
export(String) var ev_yield = ""
export(int) var base_exp = 0
export(String) var growth_rate = ""
export(int) var height = 0
export(int) var weight = 0

var poke_instance_script = preload("res://logics/game_data/pokemon_instance.gd")

func make_wild(level):
	var p = poke_instance_script.new()
	p.hp = hp
	p.max_hp=hp
	p.attack = attack
	p.defense = defense
	p.speed = speed
	p.special = special
	p.dni = 34456547 #TODO:MARIANOGNU: how to generate unique id?
	p.original_trainer = GAME_DATA.player_name
	p.to_next_level = 300 #TODO:MARIANOGNU: how to calculate next level?
	
	var learnable_indexes = []
	
	for i in range(learn_move_id.size()):
		if (learn_type[i] == CONST.LEARN_LVL_UP):
			if (learn_lvl[i] <= level):
				learnable_indexes.push_back(i)
	
	learnable_indexes.sort_custom(self, "move_is_greater")
	
	if (learnable_indexes.size() > 4):
		var moves = []
		var idx = learnable_indexes.size()-4;
		moves.push_back(learnable_indexes[idx])
		moves.push_back(learnable_indexes[idx+1])
		moves.push_back(learnable_indexes[idx+2])
		moves.push_back(learnable_indexes[idx+3])
		learnable_indexes = moves
	
	for idx in learnable_indexes:
		var move = poke_instance_script.move_instance.new()
		move.id = learn_move_id[idx]
		move.pp = DB.moves[move.id].pp
		move.max_pp = move.pp
		p.movements.push_back(move)
	
	return p

func move_is_greater(a, b):
	return learn_lvl[a]<=learn_lvl[b]