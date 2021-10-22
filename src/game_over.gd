extends Node2D

const MAIN_MENU_SCENE_PATH = "res://scenes/main_menu.tscn"

onready var winner: Label = $"CenterContainer/VBoxContainer/Winner"

func _ready() -> void:
  if global.score[0] == global.score[1]:
    winner.text = "Draw"
  elif global.score[0] > global.score[1]:
    winner.text = "Player 1 Wins" 
  else:
    winner.text = "Player 2 Wins"

func on_menu_pressed():
  get_tree().change_scene(MAIN_MENU_SCENE_PATH)

func on_exit_pressed():
  get_tree().quit()
