extends Node3D
var direction = 1
var go := true
var speed = 1
var agro = false
var spinphase := false
var captured := false
var gobackfromcomp = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if go == true:
		position.x += delta *2* direction * speed
	
	if gobackfromcomp == 1:
		position.z-= delta *3
	if gobackfromcomp == 2:

		position.z += delta *3
	if captured == true:
		look_at(Global.position)
		position += global_transform.basis * Vector3(0,0,-delta * 2) 
		go = false
		print("AGRO")
	
	if $RayCast3D.get_collider() != null:
		if $RayCast3D.get_collider().is_in_group("player"):
			
			speed = 2
			agro = true

			if spinphase == true:
				captured = true
				
		else:
			agro = false
			speed = 1
	




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		return
		get_tree().change_scene_to_file("res://objcts/dedscreen.tscn")


func _on_area_3d_area_entered(area: Area3D) -> void:
	
	if area.is_in_group("dirswitch"):
		$AnimationPlayer.play("spinn")
		$Sprite3D.billboard = false
		go = false
		spinphase = true

	if gobackfromcomp == 0:
		if area.is_in_group("enterdetector"):
			if randi_range(1,5) == 1:
				if agro == false:
				
					go = false
					gobackfromcomp = 1
	if area.is_in_group("przedzialkoniec"):
		$Timer.start()
		gobackfromcomp = 3
		



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "spinn":
		if captured == false:
			direction *= -1
			$RayCast3D.target_position.x *= -1
			$CSGBox3D.position.x *= -1
			$Sprite3D.billboard = true
			go = true
			rotation_degrees.y = 0
			spinphase = false


func _on_area_3d_area_exited(area: Area3D) -> void:
	if gobackfromcomp == 2:
		if area.is_in_group("przedzial"):
			gobackfromcomp = 0
			go = true
			print("EXITED")
	


func _on_timer_timeout() -> void:
	
	gobackfromcomp = 2
