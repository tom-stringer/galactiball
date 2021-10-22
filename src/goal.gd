extends Area2D  

const P2_EXPLOSION := preload("res://particles/goal_explosion_left.tres")

signal goal_scored(player_index)

onready var explosion: Particles2D = $Explosion

export (int) var index := 0 # player shooting into this goal

func _ready() -> void:  
  # Flip direction of p2 goal explosion
  if index == 1:
    explosion.process_material = P2_EXPLOSION  

func _process(_delta: float) -> void:  
  var ball = get_tree().get_nodes_in_group("ball")[0]
  if overlaps_body(ball):
    explosion.emitting = true
    emit_signal("goal_scored", index)

