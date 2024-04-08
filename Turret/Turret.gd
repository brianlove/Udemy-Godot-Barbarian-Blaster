extends Node3D

var enemy_path: Path3D
@export var projectile: PackedScene

@onready var barrel: MeshInstance3D = $TurretBase/TurretTop/Barrel

func _physics_process(delta: float) -> void:
	var enemy = enemy_path.get_children().back()
	look_at(enemy.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	var shot = projectile.instantiate()
	add_child(shot)
	shot.direction = global_transform.basis.z
	shot.global_position = barrel.global_position