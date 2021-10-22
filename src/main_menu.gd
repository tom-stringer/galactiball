extends Node2D

const MATCH_SCENE_PATH = "res://scenes/match.tscn"

func on_play_pressed():
    get_tree().change_scene(MATCH_SCENE_PATH)

func on_exit_pressed():
    get_tree().quit()
