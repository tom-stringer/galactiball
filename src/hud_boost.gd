extends TextureProgress

const P2_PROGRESS := preload("res://textures/hud_boost_green.png")
const GLOW := 1.2
const NORMAL := 1

export (int) var index := 0
var boost_timer: Timer

func _ready() -> void:
  boost_timer = get_tree().get_nodes_in_group("player")[index].boost_timer
  if index == 1:
    fill_mode = FILL_RIGHT_TO_LEFT
    texture_progress = P2_PROGRESS

func _process(_delta) -> void:
  value = (1 - boost_timer.time_left / boost_timer.wait_time) * 100
  # Glow if bar isn't empty, allowing alpha to be altered by HUD script
  if value > 0:
    modulate.r = GLOW
    modulate.g = GLOW
    modulate.b = GLOW
  else:
    modulate.r = NORMAL
    modulate.g = NORMAL
    modulate.b = NORMAL
    
