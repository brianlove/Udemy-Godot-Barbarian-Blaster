extends Node3D

var enemy_path: Path3D
var target: PathFollow3D

@export var projectile: PackedScene
@export var range: float = 10.0

@onready var barrel: MeshInstance3D = $TurretBase/TurretTop/Barrel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.direction = global_transform.basis.z
		shot.global_position = barrel.global_position
		animation_player.play("Fire")


func find_best_target() -> PathFollow3D:
	var current_target = null
	for enemy in enemy_path.get_children():
		var distance = global_position.distance_to(enemy.global_position)
		if enemy is PathFollow3D and distance < range:
			if current_target == null:
				current_target = enemy
			elif enemy.progress > current_target.progress:
				current_target = enemy
	return current_target
