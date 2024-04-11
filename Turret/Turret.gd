extends Node3D

var enemy_path: Path3D
var target: PathFollow3D

@export var projectile: PackedScene
@export var turret_range: float = 10.0

@onready var turret_base: MeshInstance3D = $TurretBase
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.direction = turret_base.global_transform.basis.z
		shot.global_position = cannon.global_position
		animation_player.play("Fire")


func find_best_target() -> PathFollow3D:
	var current_target = null
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < turret_range:
				if current_target == null:
					current_target = enemy
				elif enemy.progress > current_target.progress:
					current_target = enemy
	return current_target
