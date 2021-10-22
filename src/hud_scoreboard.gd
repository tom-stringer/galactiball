extends Container

const RED := Color("#ef7d57")
const GREEN := Color("#38b764")
const WHITE := Color(1, 1, 1)
const INTENSITY := 1.15

onready var p1: Label = $P1
onready var p2: Label = $P2
onready var divider: Label = $Divider

func on_goal_scored(_player_index: int) -> void:  
  p1.text = str(global.score[0])
  p2.text = str(global.score[1])
  # Highlight winning score
  if global.score[0] > global.score[1]:
    p1.modulate = RED * INTENSITY
  elif global.score[1] > global.score[0]:		
    p2.modulate = GREEN * (INTENSITY + 0.1)
  else:		
    p1.modulate = WHITE
    p2.modulate = WHITE
