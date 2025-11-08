extends Node3D
var hover = false
var currentselected = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in $hidedetect.get_children():
		
		n.body_entered.connect(_on_body_entered)
		n.body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Global.hide == true:
		$CanvasLayer/Label.text = "space to unhide"
		if Input.is_key_pressed(KEY_SPACE):
			Global.hide = false
			Input.action_release("click")
	else:
		$CanvasLayer/Label.text = "click to hide"
	if Input.is_action_just_pressed("click"):
		for n in $hidecameras.get_children():
			if n.name == Global.selected:
				n.current = true
				Global.hide = true
				




func _on_area_3d_mouse_entered() -> void:
	hover = true
	$CanvasLayer/Label.show()
	print("HELROG")

func _on_area_3d_mouse_exited() -> void:
	hover = false
	$CanvasLayer/Label.hide()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$CanvasLayer/Label.show()



func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		$CanvasLayer/Label.hide()
