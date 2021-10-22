extends Area2D

var rng = RandomNumberGenerator.new()

func _ready():
  rng.randomize()
  $Sprite.playing = true
    
func on_body_entered(_body: Node):		
  if _body is Player and _body.powerup == Player.Powerup.NONE:
    # Avoid Powerup.NONE (0)
    var powerup_type: int = rng.randi_range(1, Player.Powerup.size() - 1)		
    _body.gain_powerup(powerup_type)
    # Delete node
    get_parent().remove_child(self)
    queue_free()
