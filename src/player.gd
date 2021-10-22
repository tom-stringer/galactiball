class_name Player
extends RigidBody2D

enum Powerup { NONE, BOMB, MISSILE, FREEZE_RAY }

const BOMB := preload("res://scenes/bomb.tscn")
const MISSILE := preload("res://scenes/missile.tscn")
const FREEZE_RAY := preload("res://scenes/freeze_ray.tscn")
const P2_SHIP := preload("res://textures/player_green.png")
const SPEED := 750
const ROTATE_SPEED := 1750
const BOOST_SPEED := 50000

signal powerup_gained(powerup)
signal powerup_used

onready var bodies: CanvasLayer = $"../"
onready var ship: Sprite = $Ship
onready var flame: AnimatedSprite = $Flame
onready var ice: Sprite = $Ice
onready var boost_timer: Timer = $BoostTimer
onready var freeze_timer: Timer = $FreezeTimer

export (int) var index := 0	# player number
var controls := { # common input interface
  "forward": "p1_forward",
  "backward": "p1_backward",
  "clockwise": "p1_clockwise",
  "anticlockwise": "p1_anticlockwise",
  "powerup": "p1_powerup",
  "boost": "p1_boost"
}
var opponent: Player
var powerup = Powerup.NONE
var direction: Vector2
var rotate_direction: float
var reversing := false
var has_boost := true
var frozen := false

func _ready() -> void:		    
  if index == 0:	
    opponent = $"../Player_2"			
  else:
    opponent = $"../Player_1"
    ship.texture = P2_SHIP
    # Rename controls
    for i in controls:
      controls[i] = controls[i].replace("p1", "p2")	

func _process(_delta: float) -> void:
  if !frozen:
    move_and_rotate(_delta)    
    if Input.is_action_just_pressed(controls["powerup"]):
      use_powerup()

func _integrate_forces(_state):
  if reversing:
    applied_force = direction * SPEED * 0.5
  else:
    applied_force = direction * SPEED    
  
  # Boost if not frozen
  if !frozen and has_boost and Input.is_action_just_pressed(controls["boost"]):
    applied_force = Vector2(0, -1).rotated(rotation) * BOOST_SPEED
    has_boost = false
    boost_timer.start()
  applied_torque = rotate_direction * ROTATE_SPEED

func move_and_rotate(_delta: float) -> void:
  # Move and animate
  direction = Vector2()
  if Input.is_action_pressed(controls["forward"]):
    direction.y = -1
    reversing = false
    flame.visible = true
    flame.play("default")
  elif Input.is_action_pressed(controls["backward"]):
    direction.y = 1
    reversing = true
    flame.visible = false
    flame.frame = 0		
  else:
    flame.visible = false
    flame.frame = 0
  direction = direction.rotated(rotation)	
  
  # Turn
  if Input.is_action_pressed(controls["clockwise"]):
    rotate_direction = 1
  elif Input.is_action_pressed(controls["anticlockwise"]):
    rotate_direction = -1
  else:
    rotate_direction = 0

func gain_powerup(_powerup_type: int) -> void:
  powerup = _powerup_type
  emit_signal("powerup_gained", _powerup_type)

func use_powerup() -> void:
  # Use powerup if not frozen
  if !frozen:
    match powerup:			
      Powerup.BOMB:
        var bomb = BOMB.instance()
        bomb.global_position = global_position + Vector2(0, 24).rotated(rotation)		
        bomb.linear_velocity = linear_velocity
        bomb.angular_velocity = angular_velocity
        bodies.add_child(bomb)
      Powerup.MISSILE:
        var missile = MISSILE.instance()
        missile.global_position = global_position + Vector2(0, -24).rotated(rotation)
        missile.linear_velocity = linear_velocity
        missile.rotation = rotation
        missile.target = opponent
        bodies.add_child(missile)		      	
      Powerup.FREEZE_RAY:            
        var ray: RayCast2D = FREEZE_RAY.instance()
        add_child(ray)
    emit_signal("powerup_used")
    powerup = Powerup.NONE

func on_boost_timer() -> void:
  has_boost = true

# Freeze this player, called by freeze ray
func freeze() -> void:  
  freeze_timer.start()
  frozen = true
  ice.visible = true
  flame.visible = false
  flame.frame = 0  

# Unfreeze this player, called on timer end
func on_freeze_timer() -> void:  
  frozen = false
  ice.visible = false
