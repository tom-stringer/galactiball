extends RayCast2D

onready var left_ray: RayCast2D = $LeftRay
onready var right_ray: RayCast2D = $RightRay
onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
  # Exclude player from collision detection
  add_exception(get_parent())
  left_ray.add_exception(get_parent())
  right_ray.add_exception(get_parent())

func _process(_delta) -> void:
  # Freeze player if hit by any ray
  var colliders := [get_collider(), left_ray.get_collider(), right_ray.get_collider()]  
  for collider in colliders:
    if collider != null and collider.get_groups().has("player"):
      collider.freeze()
  animation_player.play("fade_out")

func on_fadeout_finished(_anim_name):
  get_parent().remove_child(self)
  queue_free()
