extends Node3D
var direction = 1
var go := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if go == true:
		position.x += delta *3* direction



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://objcts/dedscreen.tscn")


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("dirswitch"):
		direction *= -1
	if area.is_in_group("enterdetector"):
		if randi_range(1,5) == 1:
			go = false
			position.z -= 2
			$Timer.start()


func _on_timer_timeout() -> void:
	go = true
	position.z += 2
