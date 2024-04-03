extends Area3D

@export var speed := 30.0

var direction := Vector3.FORWARD

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()
