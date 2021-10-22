extends Area2D

const POWERUP := preload("res://scenes/powerup.tscn")
const MAX_POWERUPS := 3

onready var timer: Timer = $Timer

var rng := RandomNumberGenerator.new()
var extents: Vector2

func _ready():
  rng.randomize()
  extents = $Area.shape.extents
  restart_timer()

# Spawn powerup if not at max, reset timer
func on_timer() -> void:        
  if get_tree().get_nodes_in_group("powerup").size() < MAX_POWERUPS:
    var powerup = POWERUP.instance()        
    powerup.position.x = rng.randf_range(-extents.x, extents.x)
    powerup.position.y = rng.randf_range(-extents.y, extents.y)
    add_child(powerup)
  restart_timer()

func restart_timer() -> void:
  timer.start(rng.randf_range(5, 15))    
