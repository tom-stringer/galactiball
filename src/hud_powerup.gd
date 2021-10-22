extends AnimatedSprite

const P2_INPUT := preload("res://textures/atlas_textures/button_a.tres")
const BOMB := preload("res://textures/bomb.png")
const MISSILE := preload("res://textures/atlas_textures/icon_missile.tres")
const FREEZE_RAY := preload("res://textures/ice_small.png")

onready var powerup: Sprite = $Powerup
onready var input: Sprite = $Input

export (int) var index := 0

func _ready() -> void:
  # Retexture and realign input icon for player 2
  if index == 1:
    input.texture = P2_INPUT
    input.position.x = -input.position.x

# Change icon when powerup gained
func on_powerup_gained(_powerup_type: int) -> void:	
  var sprite := get_sprite(_powerup_type)
  if sprite == null:
    powerup.visible = false
    input.visible = false
    play("default")
    return
  # Valid sprite, set icon to its properties
  play("powerup")
  input.visible = true
  powerup.visible = true
  powerup.texture = sprite
    
# Clear icon when powerup used
func on_powerup_used() -> void:
  play("default")
  powerup.visible = false
  input.visible = false

# Get sprite from powerup enum type
# Returns null if player has no powerup
func get_sprite(_powerup_type: int) -> Texture:
  match _powerup_type:
    Player.Powerup.NONE:
      return null
    Player.Powerup.BOMB:			
      return BOMB
    Player.Powerup.MISSILE:
      return MISSILE
    Player.Powerup.FREEZE_RAY:
      return FREEZE_RAY
    _:
      return null
