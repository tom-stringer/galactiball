extends Explosive

const SPEED := 500
const ROTATE_SPEED := 500

onready var sprite: AnimatedSprite = $Sprite
onready var explosion: Particles2D = $Explosion

var target: Node2D
var direction: Vector2
var rotate_direction: float
var exploded := false

func _ready() -> void:
  force = 250
  area = $BlastRadius
  sprite.playing = true

func _process(_delta: float) -> void:
  if exploded and !explosion.emitting:
    get_parent().remove_child(self)
    queue_free()

  # Chase the target
  var to_target = (target.global_position - global_position).normalized()
  direction = Vector2.UP.rotated(rotation)
  rotate_direction = to_target.cross(direction)

  # Explode on contact
  if get_colliding_bodies().size() > 0:
    explode()

func _integrate_forces(_state) -> void:
  applied_force = direction * SPEED
  applied_torque = -rotate_direction * ROTATE_SPEED

func explode() -> void:
  exploded = true
  sprite.visible = false
  explosion.emitting = true
  .explode() # apply forces
