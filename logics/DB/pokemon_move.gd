
extends Node

export(String) var name = "" # the resource name e.g. Overgrow.
export(int) var id = 0 # the id of the resource.
export(String) var description = "" # a description of the move.
export(int) var power = 0 # the power of the move.
export(int) var accuracy = 0 # the accuracy of the move.
export(int) var pp = 0 # the pp points of the move.
export(int,"None, Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel, Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy") var type = 1