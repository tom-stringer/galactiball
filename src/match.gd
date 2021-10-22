extends Node2D

const WIN_SCORE := 10
const GAME_OVER_SCENE_PATH := "res://scenes/game_over.tscn"

var viewport_height: int
var start_transforms: Dictionary # map node names to their start transform

func _ready() -> void:
  # Store starting transform of nodes in group reset
  for node in get_tree().get_nodes_in_group("reset"):
    start_transforms[node.name] = node.get_global_transform()	
  viewport_height = int(get_viewport_rect().size.y)
  
  # Reset score from previous games
  global.score = [0, 0]

func _process(_delta: float) -> void:
  if global.score[0] == WIN_SCORE or global.score[1] == WIN_SCORE:
    get_tree().change_scene(GAME_OVER_SCENE_PATH)
  vertical_wrap()	

# Wrap vertical position of nodes in group to other end of viewport
func vertical_wrap() -> void:	
  var wrap_nodes = get_tree().get_nodes_in_group("wrap")
  for node in wrap_nodes:
    if node.global_position.y > viewport_height:
      node.global_position.y = 0
    elif node.global_position.y < 0:
      node.global_position.y = viewport_height

func on_goal_scored(_player_index: int) -> void:
  # Reset positions of all nodes in group reset
  for node in get_tree().get_nodes_in_group("reset"):
    var node_transform: Transform2D = start_transforms[node.name]
    node.global_position = node_transform.origin
    node.rotation = node_transform.get_rotation()
    if node is RigidBody2D:
      node.linear_velocity = Vector2()
      node.angular_velocity = 0
  # Update score
  global.score[_player_index] += 1
