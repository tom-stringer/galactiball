extends Explosive

onready var explosion: Particles2D = $Explosion
onready var animation_player: AnimationPlayer = $AnimationPlayer

var exploded := false

func _ready() -> void:
  force = 1250
  area = $BlastRadius
  animation_player.play("flash")

func _process(_delta: float) -> void:
  if exploded and !explosion.emitting:
    get_parent().remove_child(self)
    queue_free()

func explode() -> void:
  exploded = true
  $Sprite.visible = false
  $Zone.visible = false
  explosion.emitting = true
  .explode() # apply forces
