# Abstract superclass to all objects that need access to the explode function
class_name Explosive
extends RigidBody2D

# Must be set in subclass
var area: Area2D
var force: float

func explode() -> void:	
  var bodies = area.get_overlapping_bodies()
  for body in bodies:
    if body != self and body is RigidBody2D:
      var direction = body.global_position - global_position
      var velocity = direction.normalized() * force		
      var offset = global_position - body.global_position
      body.apply_impulse(offset, velocity)	
