extends Area3D


@export_file("*.tscn") var next_level


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_file", next_level)
