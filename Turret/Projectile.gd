extends Area3D

@export var damage: int = 10
@export var speed := 30.0

var direction := Vector3.FORWARD

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group('enemy_area'):
		area.get_parent_node_3d().take_damage(damage)
		queue_free()
