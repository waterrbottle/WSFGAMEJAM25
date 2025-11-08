extends Node3D
var direction = 1
var go := true
var speed = 1
var agro = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if go == true:
		position.x += delta *3* direction * speed
	if $RayCast3D.get_collider() != null:
		if $RayCast3D.get_collider().is_in_group("player"):
			speed = 2
			agro = true
		else:
			speed = 1



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://objcts/dedscreen.tscn")


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("dirswitch"):
		direction *= -1
		$RayCast3D.target_position.x *= -1
		$CSGBox3D.position.x *= -1
	if area.is_in_group("enterdetector"):
		if randi_range(1,5) == 1:
			if agro == false:
				go = false
			#position.z -= 2
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", Vector3(position.x,position.y, -1), 2.0).set_trans(Tween.TRANS_SINE)

				$Timer.start()
	

func _on_timer_timeout() -> void:
	go = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(position.x,position.y, 1.3), 2.0).set_trans(Tween.TRANS_SINE)
