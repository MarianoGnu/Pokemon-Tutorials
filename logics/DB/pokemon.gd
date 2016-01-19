
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


func _ready():
	# Initialization here
	pass


