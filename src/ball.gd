extends RigidBody2D

func _ready() -> void:
  $Sprite.playing = true

func _process(_delta: float) -> void:
  # TODO: modulate colour intensity based on distance to goal
  pass
