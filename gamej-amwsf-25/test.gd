extends Sprite2D
var licznik = 0
var tekst = "afegrsefgrsr"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str(licznik)
	licznik += 1
