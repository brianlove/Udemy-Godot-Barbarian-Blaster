extends Node3D

@export var max_health: int = 5

@onready var health_label: Label3D = $HealthLabel

var current_health: int:
	set(new_health):
		current_health = new_health
		health_label.text = "{curr}/{max}".format({"curr": current_health, "max": max_health})
		var health_frac = float(current_health-1) / (max_health-1)
		health_label.modulate = Color.RED.lerp(Color.WHITE, health_frac)
		if current_health < 1:
			get_tree().reload_current_scene()
	get:
		return current_health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


func take_damage(damage: int = 1) -> void:
	current_health -= damage
