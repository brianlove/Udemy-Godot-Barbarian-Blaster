extends PathFollow3D

@export var max_health: int = 50
@export var speed: float = 5

@onready var base = get_tree().get_first_node_in_group("base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_health: int:
	set(new_health):
		if new_health < current_health:
			animation_player.play("TakeDamage")
		current_health = new_health
		if current_health < 1:
			queue_free()
	get:
		return current_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1:
		base.take_damage()
		set_process(false)


func take_damage(damage: int = 1) -> void:
	current_health -= damage
