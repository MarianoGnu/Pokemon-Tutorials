
extends Node

var player_name = "RED"

var party = []
var box1 = []
var box2 = []
var box3 = []
var box4 = []
var box5 = []
var box6 = []
var box7 = []
var box8 = []
var box9 = []
var box10 = []
var box11 = []
var box12 = []
var box13 = []
var box14 = []
var box15 = []
var box16 = []
var box17 = []
var box18 = []
var box19 = []
var box20 = []

func _ready():
	party.push_back(DB.pokemons[7].make_wild(7))
	party.push_back(DB.pokemons[4].make_wild(16))
	for m in party[1].movements:
		print (DB.moves[m.id].name)
		print (str(m.pp))

