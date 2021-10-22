extends Control

export (bool) var can_pause := true

var paused := false

func _input(_event: InputEvent) -> void:
    if can_pause and _event.is_action_pressed("control_pause"):
        get_tree().paused = !get_tree().paused
        visible = !visible

func on_exit_pressed() -> void:    
    visible = false
    get_tree().paused = false

func on_fullscreen_pressed() -> void:
    OS.window_fullscreen = !OS.window_fullscreen
    OS.window_borderless = !OS.window_borderless
