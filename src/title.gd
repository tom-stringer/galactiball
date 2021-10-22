extends Sprite

const GREEN := preload("res://textures/title_green.png")
const BLUE := preload("res://textures/title_blue.png")

var rng := RandomNumberGenerator.new()

func _ready() -> void:
    # Randomly choose red, green or blue title shadow
    rng.randomize()
    var color := rng.randi_range(0, 2)    
    if color == 1:
        texture = GREEN
    elif color == 2:
        texture = BLUE
