extends MarginContainer

@export var starting_gold: int = 150

@onready var label: Label = $Label

var gold: int:
	set(new_gold):
		gold = max(new_gold, 0)
		label.text = "Gold: " + str(gold)
	get:
		return gold


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gold = starting_gold
