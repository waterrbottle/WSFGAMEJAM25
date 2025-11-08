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
	if hover == true:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			for n in $hidecameras.get_children():
				if n.name == currentselected:
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
		currentselected = body.name


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		$CanvasLayer/Label.hide()
		currentselected = ""
